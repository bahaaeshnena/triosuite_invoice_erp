import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_snack_bar.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/repo/settings_repo.dart';
import 'package:triosuite_invoice_erp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CompanySettingsView extends StatelessWidget {
  const CompanySettingsView({super.key});

  static const routeName = 'company_settings_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(settingsRepo: getIt<SettingsRepo>())..load(),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).companySettings)),
        body: const _CompanySettingsBody(),
      ),
    );
  }
}

class _CompanySettingsBody extends StatefulWidget {
  const _CompanySettingsBody();

  @override
  State<_CompanySettingsBody> createState() => _CompanySettingsBodyState();
}

class _CompanySettingsBodyState extends State<_CompanySettingsBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameAr = TextEditingController();
  final _nameEn = TextEditingController();
  final _prefix = TextEditingController();
  int? _currencyId;
  bool _initialized = false;

  @override
  void dispose() {
    _nameAr.dispose();
    _nameEn.dispose();
    _prefix.dispose();
    super.dispose();
  }

  void _initialize(CompanySettingsEntity settings) {
    if (_initialized) return;
    _initialized = true;
    _nameAr.text = settings.companyNameAr;
    _nameEn.text = settings.companyNameEn;
    _prefix.text = settings.invoicePrefix;
    _currencyId = settings.defaultCurrencyId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsSaved) {
          CustomSnackBar.success(context, S.of(context).settingsSaved);
        } else if (state is SettingsSaveFailure) {
          CustomSnackBar.error(context, state.failure.message);
        }
      },
      builder: (context, state) {
        if (state is SettingsLoading || state is SettingsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SettingsLoadFailure) {
          return _SettingsLoadFailure(
            message: state.failure.message,
            onRetry: context.read<SettingsCubit>().load,
          );
        }
        if (state is! SettingsReady) return const SizedBox.shrink();
        _initialize(state.settings);
        return _buildForm(context, state, state is SettingsSaving);
      },
    );
  }

  Widget _buildForm(BuildContext context, SettingsReady state, bool isSaving) {
    final tr = S.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameAr,
                        enabled: !isSaving,
                        textDirection: TextDirection.rtl,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: tr.companyNameAr,
                        ),
                        validator: _required,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nameEn,
                        enabled: !isSaving,
                        textDirection: TextDirection.ltr,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: tr.companyNameEn,
                        ),
                        validator: _required,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _currencyId,
                        decoration: InputDecoration(
                          labelText: tr.defaultCurrency,
                        ),
                        items: state.currencies
                            .map(
                              (currency) => DropdownMenuItem(
                                value: currency.id,
                                child: Text(
                                  '${currency.code} - ${isArabic ? currency.nameAr : currency.nameEn}',
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: isSaving
                            ? null
                            : (value) => setState(() => _currencyId = value),
                        validator: (value) =>
                            value == null ? tr.isRequired : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _prefix,
                        enabled: !isSaving,
                        maxLength: 20,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: tr.invoicePrefix,
                        ),
                        validator: _required,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: FilledButton.icon(
                          onPressed: isSaving ? null : _save,
                          icon: isSaving
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save_outlined),
                          label: Text(tr.saveSettings),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? S.of(context).isRequired : null;

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SettingsCubit>().save(
      CompanySettingsFormEntity(
        companyNameAr: _nameAr.text.trim(),
        companyNameEn: _nameEn.text.trim(),
        defaultCurrencyId: _currencyId!,
        invoicePrefix: _prefix.text.trim().toUpperCase(),
      ),
    );
  }
}

class _SettingsLoadFailure extends StatelessWidget {
  const _SettingsLoadFailure({required this.message, required this.onRetry});

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
