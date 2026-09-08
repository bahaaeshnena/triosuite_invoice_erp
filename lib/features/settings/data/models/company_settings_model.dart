import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';

class CompanySettingsModel {
  const CompanySettingsModel(this.json);

  final Map<String, dynamic> json;

  factory CompanySettingsModel.fromJson(Map<String, dynamic> json) =>
      CompanySettingsModel(json);

  CompanySettingsEntity toEntity() => CompanySettingsEntity(
    id: _int(json['id']),
    companyNameAr: json['companyNameAr'] as String,
    companyNameEn: json['companyNameEn'] as String,
    defaultCurrencyId: _int(json['defaultCurrencyId']),
    defaultCurrencyCode: json['defaultCurrencyCode'] as String,
    invoicePrefix: json['invoicePrefix'] as String,
  );

  int _int(Object? value) => value is int ? value : int.parse('$value');
}
