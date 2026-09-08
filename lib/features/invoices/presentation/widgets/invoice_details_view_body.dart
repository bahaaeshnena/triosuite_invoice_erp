import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_snack_bar.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/invoice_status_badge.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/invoice_details_cubit.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/total_row.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsViewBody extends StatelessWidget {
  const InvoiceDetailsViewBody({required this.invoiceId, super.key});

  final int invoiceId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceDetailsCubit, InvoiceDetailsState>(
      listener: (context, state) {
        if (state is InvoiceDetailsActionFailure) {
          CustomSnackBar.error(context, state.failure.message);
        }
      },
      builder: (context, state) {
        if (state is InvoiceDetailsLoading || state is InvoiceDetailsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InvoiceDetailsLoadFailure) {
          return _LoadFailure(
            message: state.failure.message,
            onRetry: () => context.read<InvoiceDetailsCubit>().load(invoiceId),
          );
        }
        if (state is! InvoiceDetailsSuccess) return const SizedBox.shrink();
        return _DetailsContent(
          invoice: state.invoice,
          isBusy: state is InvoiceDetailsActionLoading,
        );
      },
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.invoice, required this.isBusy});

  final InvoiceDetailsEntity invoice;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final tr = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final customerName = isArabic
        ? invoice.customerNameAr
        : invoice.customerNameEn;
    final notes = isArabic ? invoice.notesAr : invoice.notesEn;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 38),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(invoice: invoice, locale: locale),
                const SizedBox(height: 16),
                InvoiceSectionCard(
                  title: tr.billTo,
                  icon: Icons.business_outlined,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      child: Icon(Icons.business_center_outlined),
                    ),
                    title: Text(customerName),
                    subtitle: Text('${tr.customer} #${invoice.customerId}'),
                  ),
                ),
                const SizedBox(height: 16),
                InvoiceSectionCard(
                  title: tr.invoiceItems,
                  icon: Icons.inventory_2_outlined,
                  child: Column(
                    children: [
                      for (
                        var index = 0;
                        index < invoice.items.length;
                        index++
                      ) ...[
                        _InvoiceItemRow(
                          item: invoice.items[index],
                          currencyCode: invoice.currencyCode,
                          isArabic: isArabic,
                        ),
                        if (index < invoice.items.length - 1)
                          const Divider(height: 28),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InvoiceSectionCard(
                  title: tr.paymentSummary,
                  icon: Icons.account_balance_wallet_outlined,
                  child: Column(
                    children: [
                      TotalRow(
                        label: tr.subtotal,
                        value: _money(invoice.subTotal, invoice.currencyCode),
                      ),
                      const SizedBox(height: 10),
                      TotalRow(
                        label: tr.taxAmount,
                        value: _money(invoice.taxAmount, invoice.currencyCode),
                      ),
                      const Divider(height: 26),
                      TotalRow(
                        label: tr.grandTotal,
                        value: _money(
                          invoice.totalAmount,
                          invoice.currencyCode,
                        ),
                        isEmphasized: true,
                      ),
                      const SizedBox(height: 10),
                      TotalRow(
                        label: tr.baseCurrencyTotal,
                        value: invoice.baseCurrencyTotal.toStringAsFixed(3),
                      ),
                    ],
                  ),
                ),
                if (notes != null && notes.trim().isNotEmpty) ...[
                  const SizedBox(height: 16),
                  InvoiceSectionCard(
                    title: tr.notes,
                    icon: Icons.notes_rounded,
                    child: Text(notes),
                  ),
                ],
                if (invoice.status.toUpperCase() == 'CANCELLED') ...[
                  const SizedBox(height: 16),
                  InvoiceSectionCard(
                    title: tr.cancellationReason,
                    icon: Icons.cancel_outlined,
                    child: Text(
                      (isArabic
                              ? invoice.cancellationReasonAr
                              : invoice.cancellationReasonEn) ??
                          invoice.cancellationReasonAr ??
                          '',
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                _Actions(invoice: invoice, isBusy: isBusy),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _money(double value, String currencyCode) =>
      '${value.toStringAsFixed(3)} $currencyCode';
}

class _Header extends StatelessWidget {
  const _Header({required this.invoice, required this.locale});

  final InvoiceDetailsEntity invoice;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final tr = S.of(context);
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, const Color(0xFF174AA8)],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '#${invoice.invoiceNumber}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              InvoiceStatusBadge(status: invoiceStatusFromCode(invoice.status)),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 24,
            runSpacing: 10,
            children: [
              _HeaderValue(
                label: tr.issuedOn,
                value: DateFormat.yMd(locale).format(invoice.invoiceDate),
              ),
              _HeaderValue(label: tr.taxMode, value: invoice.taxMode),
              _HeaderValue(
                label: tr.exchangeRate,
                value: invoice.exchangeRate.toStringAsFixed(6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderValue extends StatelessWidget {
  const _HeaderValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _InvoiceItemRow extends StatelessWidget {
  const _InvoiceItemRow({
    required this.item,
    required this.currencyCode,
    required this.isArabic,
  });

  final InvoiceItemEntity item;
  final String currencyCode;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final tr = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${item.itemCode} - ${isArabic ? item.itemNameAr : item.itemNameEn}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 20,
          runSpacing: 6,
          children: [
            Text('${tr.quantity}: ${item.quantity} ${item.unitCode}'),
            Text(
              '${tr.price}: ${item.unitPrice.toStringAsFixed(3)} $currencyCode',
            ),
            Text('${tr.tax}: ${item.taxRate}%'),
            Text(
              '${tr.total}: ${item.lineTotal.toStringAsFixed(3)} $currencyCode',
            ),
          ],
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.invoice, required this.isBusy});

  final InvoiceDetailsEntity invoice;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final status = invoice.status.toUpperCase();
    if (status == 'CANCELLED') return const SizedBox.shrink();
    final tr = S.of(context);
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 12,
      runSpacing: 10,
      children: [
        OutlinedButton.icon(
          onPressed: isBusy ? null : () => _cancel(context),
          icon: const Icon(Icons.cancel_outlined),
          label: Text(tr.cancelInvoice),
        ),
        if (status == 'DRAFT')
          FilledButton.icon(
            onPressed: isBusy
                ? null
                : () => context.read<InvoiceDetailsCubit>().approve(),
            icon: isBusy
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_circle_outline_rounded),
            label: Text(tr.approveInvoice),
          ),
      ],
    );
  }

  Future<void> _cancel(BuildContext context) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).cancelInvoice),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 500,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: S.of(context).cancellationReason,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) Navigator.pop(dialogContext, value);
            },
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
    controller.dispose();
    if (reason != null && context.mounted) {
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      context.read<InvoiceDetailsCubit>().cancel(
        reasonAr: reason,
        reasonEn: isArabic ? null : reason,
      );
    }
  }
}

class _LoadFailure extends StatelessWidget {
  const _LoadFailure({required this.message, required this.onRetry});

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
