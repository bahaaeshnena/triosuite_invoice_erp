import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_snack_bar.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/create_invoice_cubit.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/total_row.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CreateInvoiceViewBody extends StatefulWidget {
  const CreateInvoiceViewBody({super.key});

  @override
  State<CreateInvoiceViewBody> createState() => _CreateInvoiceViewBodyState();
}

class _CreateInvoiceViewBodyState extends State<CreateInvoiceViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _exchangeRate = TextEditingController(text: '1');
  final _notes = TextEditingController();
  final List<_InvoiceLineDraft> _lines = [];
  DateTime _invoiceDate = DateTime.now();
  int? _customerId;
  int? _currencyId;
  String? _taxMode;
  bool _initialized = false;

  @override
  void dispose() {
    _exchangeRate.dispose();
    _notes.dispose();
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  void _initialize(InvoiceLookupsEntity lookups) {
    if (_initialized) return;
    _initialized = true;
    _customerId = lookups.customers.firstOrNull?.id;
    final configuredCurrency = lookups.currencies
        .where((value) => value.id == lookups.defaultCurrencyId)
        .firstOrNull;
    final currency =
        configuredCurrency ??
        lookups.currencies.where((value) => value.isBaseCurrency).firstOrNull;
    _currencyId = currency?.id ?? lookups.currencies.firstOrNull?.id;
    _taxMode = lookups.taxModes.firstOrNull?.code ?? 'EXCLUSIVE';
    _lines.add(_InvoiceLineDraft());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateInvoiceCubit, CreateInvoiceState>(
      listener: (context, state) {
        if (state is CreateInvoiceSuccess) {
          Navigator.pushReplacementNamed(
            context,
            InvoiceDetailsView.routeName,
            arguments: state.invoice.id,
          );
        } else if (state is CreateInvoiceFailure) {
          CustomSnackBar.error(context, state.failure.message);
        }
      },
      builder: (context, state) {
        if (state is CreateInvoiceLoading || state is CreateInvoiceInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CreateInvoiceLoadFailure) {
          return _RetryView(
            message: state.failure.message,
            onRetry: context.read<CreateInvoiceCubit>().loadLookups,
          );
        }
        if (state is! CreateInvoiceReady) return const SizedBox.shrink();
        _initialize(state.lookups);
        return _buildForm(context, state.lookups, state is CreateInvoiceSaving);
      },
    );
  }

  Widget _buildForm(
    BuildContext context,
    InvoiceLookupsEntity lookups,
    bool isSaving,
  ) {
    final tr = S.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final selectedCurrency = lookups.currencies
        .where((value) => value.id == _currencyId)
        .firstOrNull;
    final totals = _calculateTotals();

    return SafeArea(
      top: false,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 38),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    tr.createInvoiceSubtitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  InvoiceSectionCard(
                    title: tr.customerDetails,
                    icon: Icons.person_outline_rounded,
                    child: DropdownButtonFormField<int>(
                      initialValue: _customerId,
                      decoration: InputDecoration(labelText: tr.customer),
                      items: lookups.customers
                          .map(
                            (customer) => DropdownMenuItem(
                              value: customer.id,
                              child: Text(
                                isArabic ? customer.nameAr : customer.nameEn,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: isSaving
                          ? null
                          : (value) => setState(() => _customerId = value),
                      validator: (value) =>
                          value == null ? tr.isRequired : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InvoiceSectionCard(
                    title: tr.invoiceDetails,
                    icon: Icons.event_note_outlined,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 280,
                          child: TextFormField(
                            readOnly: true,
                            initialValue: tr.generatedAutomatically,
                            decoration: InputDecoration(
                              labelText: tr.invoiceNumber,
                              prefixIcon: const Icon(Icons.tag_rounded),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: TextFormField(
                            key: ValueKey(_invoiceDate),
                            readOnly: true,
                            initialValue: DateFormat.yMd(
                              Localizations.localeOf(context).toString(),
                            ).format(_invoiceDate),
                            onTap: isSaving ? null : _pickDate,
                            decoration: InputDecoration(
                              labelText: tr.invoiceDate,
                              prefixIcon: const Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: DropdownButtonFormField<int>(
                            initialValue: _currencyId,
                            decoration: InputDecoration(labelText: tr.currency),
                            items: lookups.currencies
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency.id,
                                    child: Text(currency.code),
                                  ),
                                )
                                .toList(),
                            onChanged: isSaving
                                ? null
                                : (value) => setState(() {
                                    _currencyId = value;
                                    final selected = lookups.currencies
                                        .where((item) => item.id == value)
                                        .firstOrNull;
                                    if (selected?.isBaseCurrency ?? false) {
                                      _exchangeRate.text = '1';
                                    }
                                  }),
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: TextFormField(
                            controller: _exchangeRate,
                            enabled: !isSaving,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: tr.exchangeRate,
                            ),
                            validator: _positiveNumberValidator,
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: DropdownButtonFormField<String>(
                            initialValue: _taxMode,
                            decoration: InputDecoration(labelText: tr.taxMode),
                            items: lookups.taxModes
                                .map(
                                  (mode) => DropdownMenuItem(
                                    value: mode.code,
                                    child: Text(
                                      isArabic ? mode.nameAr : mode.nameEn,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: isSaving
                                ? null
                                : (value) => setState(() => _taxMode = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  InvoiceSectionCard(
                    title: tr.invoiceItems,
                    icon: Icons.inventory_2_outlined,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: tr.scanBarcode,
                          onPressed: isSaving
                              ? null
                              : () => _scanBarcode(lookups),
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ),
                        TextButton.icon(
                          onPressed: isSaving ? null : _addLine,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(tr.addItem),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        for (var index = 0; index < _lines.length; index++) ...[
                          _buildLine(
                            context,
                            lookups,
                            _lines[index],
                            index,
                            isSaving,
                            isArabic,
                          ),
                          if (index < _lines.length - 1)
                            const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  InvoiceSectionCard(
                    title: tr.notes,
                    icon: Icons.notes_rounded,
                    child: TextFormField(
                      controller: _notes,
                      enabled: !isSaving,
                      maxLines: 3,
                      maxLength: 500,
                      decoration: InputDecoration(hintText: tr.notesHint),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              TotalRow(
                                label: tr.subtotal,
                                value: _money(
                                  totals.subtotal,
                                  selectedCurrency,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TotalRow(
                                label: tr.taxAmount,
                                value: _money(totals.tax, selectedCurrency),
                              ),
                              const Divider(height: 26),
                              TotalRow(
                                label: tr.grandTotal,
                                value: _money(totals.total, selectedCurrency),
                                isEmphasized: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildActions(context, isSaving),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLine(
    BuildContext context,
    InvoiceLookupsEntity lookups,
    _InvoiceLineDraft line,
    int index,
    bool isSaving,
    bool isArabic,
  ) {
    final tr = S.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 310,
            child: DropdownButtonFormField<int>(
              initialValue: line.item?.id,
              decoration: InputDecoration(labelText: tr.item),
              items: lookups.items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(
                        '${item.code} - ${isArabic ? item.nameAr : item.nameEn}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: isSaving
                  ? null
                  : (id) {
                      final item = lookups.items
                          .where((value) => value.id == id)
                          .firstOrNull;
                      setState(() => line.setItem(item));
                    },
              validator: (value) => value == null ? tr.isRequired : null,
            ),
          ),
          SizedBox(
            width: 120,
            child: TextFormField(
              controller: line.quantity,
              enabled: !isSaving,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: tr.quantity),
              validator: _positiveNumberValidator,
              onChanged: (_) => setState(() {}),
            ),
          ),
          SizedBox(
            width: 145,
            child: TextFormField(
              controller: line.unitPrice,
              enabled: !isSaving,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: tr.price),
              validator: _nonNegativeNumberValidator,
              onChanged: (_) => setState(() {}),
            ),
          ),
          SizedBox(
            width: 120,
            child: TextFormField(
              controller: line.taxRate,
              enabled: !isSaving,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: tr.tax, suffixText: '%'),
              validator: _taxValidator,
              onChanged: (_) => setState(() {}),
            ),
          ),
          IconButton(
            onPressed: isSaving || _lines.length == 1
                ? null
                : () => _removeLine(index),
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, bool isSaving) {
    final tr = S.of(context);
    final draft = OutlinedButton.icon(
      onPressed: isSaving ? null : () => _save(approve: false),
      icon: const Icon(Icons.save_outlined),
      label: Text(tr.saveDraft),
    );
    final approve = FilledButton.icon(
      onPressed: isSaving ? null : () => _save(approve: true),
      icon: isSaving
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.check_rounded),
      label: Text(tr.issueInvoice),
    );
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 12,
      runSpacing: 10,
      children: [draft, approve],
    );
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: _invoiceDate,
    );
    if (value != null) setState(() => _invoiceDate = value);
  }

  void _addLine() => setState(() => _lines.add(_InvoiceLineDraft()));

  void _removeLine(int index) {
    setState(() => _lines.removeAt(index).dispose());
  }

  Future<void> _scanBarcode(InvoiceLookupsEntity lookups) async {
    final barcode = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _BarcodeScannerSheet(),
    );
    if (barcode == null || !mounted) return;
    final item = lookups.items
        .where((value) => value.barcode == barcode)
        .firstOrNull;
    if (item == null) {
      CustomSnackBar.warning(context, S.of(context).barcodeItemNotFound);
      return;
    }
    final emptyLine = _lines.where((line) => line.item == null).firstOrNull;
    setState(() {
      if (emptyLine != null) {
        emptyLine.setItem(item);
      } else {
        _lines.add(_InvoiceLineDraft()..setItem(item));
      }
    });
  }

  void _save({required bool approve}) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final notes = _notes.text.trim();
    final invoice = SaveInvoiceEntity(
      invoiceDate: _invoiceDate,
      customerId: _customerId!,
      currencyId: _currencyId!,
      exchangeRate: double.parse(_exchangeRate.text.trim()),
      taxMode: _taxMode!,
      notesAr: isArabic && notes.isNotEmpty ? notes : null,
      notesEn: !isArabic && notes.isNotEmpty ? notes : null,
      items: _lines
          .map(
            (line) => SaveInvoiceItemEntity(
              itemId: line.item!.id,
              unitId: line.item!.unitId,
              quantity: double.parse(line.quantity.text.trim()),
              unitPrice: double.parse(line.unitPrice.text.trim()),
              taxRate: double.parse(line.taxRate.text.trim()),
            ),
          )
          .toList(),
    );
    context.read<CreateInvoiceCubit>().save(invoice, approve: approve);
  }

  String? _positiveNumberValidator(String? value) {
    final number = double.tryParse(value?.trim() ?? '');
    return number == null || number <= 0 ? S.of(context).positiveNumber : null;
  }

  String? _nonNegativeNumberValidator(String? value) {
    final number = double.tryParse(value?.trim() ?? '');
    return number == null || number < 0
        ? S.of(context).nonNegativeNumber
        : null;
  }

  String? _taxValidator(String? value) {
    final number = double.tryParse(value?.trim() ?? '');
    return number == null || number < 0 || number > 100
        ? S.of(context).invalidTaxRate
        : null;
  }

  ({double subtotal, double tax, double total}) _calculateTotals() {
    var subtotal = 0.0;
    var tax = 0.0;
    var total = 0.0;
    for (final line in _lines) {
      final quantity = double.tryParse(line.quantity.text) ?? 0;
      final price = double.tryParse(line.unitPrice.text) ?? 0;
      final rate = double.tryParse(line.taxRate.text) ?? 0;
      final gross = quantity * price;
      final lineSubtotal = _taxMode == 'INCLUSIVE'
          ? gross / (1 + rate / 100)
          : gross;
      final lineTotal = _taxMode == 'INCLUSIVE'
          ? gross
          : gross * (1 + rate / 100);
      subtotal += lineSubtotal;
      tax += lineTotal - lineSubtotal;
      total += lineTotal;
    }
    return (subtotal: subtotal, tax: tax, total: total);
  }

  String _money(double value, CurrencyEntity? currency) =>
      '${value.toStringAsFixed(3)} ${currency?.code ?? ''}';
}

class _InvoiceLineDraft {
  ItemEntity? item;
  final quantity = TextEditingController(text: '1');
  final unitPrice = TextEditingController(text: '0');
  final taxRate = TextEditingController(text: '0');

  void setItem(ItemEntity? value) {
    item = value;
    if (value != null) {
      unitPrice.text = value.unitPrice.toString();
      taxRate.text = value.taxRate.toString();
    }
  }

  void dispose() {
    quantity.dispose();
    unitPrice.dispose();
    taxRate.dispose();
  }
}

class _BarcodeScannerSheet extends StatefulWidget {
  const _BarcodeScannerSheet();

  @override
  State<_BarcodeScannerSheet> createState() => _BarcodeScannerSheetState();
}

class _BarcodeScannerSheetState extends State<_BarcodeScannerSheet> {
  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .72,
      child: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              if (_handled) return;
              final value = capture.barcodes.firstOrNull?.rawValue;
              if (value == null || value.isEmpty) return;
              _handled = true;
              Navigator.pop(context, value);
            },
          ),
          PositionedDirectional(
            top: 12,
            end: 12,
            child: IconButton.filled(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _RetryView extends StatelessWidget {
  const _RetryView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: Text(S.of(context).retry)),
          ],
        ),
      ),
    );
  }
}
