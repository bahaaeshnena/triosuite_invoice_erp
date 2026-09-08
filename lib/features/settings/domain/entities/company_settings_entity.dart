class CompanySettingsEntity {
  const CompanySettingsEntity({
    required this.id,
    required this.companyNameAr,
    required this.companyNameEn,
    required this.defaultCurrencyId,
    required this.defaultCurrencyCode,
    required this.invoicePrefix,
  });

  final int id;
  final String companyNameAr;
  final String companyNameEn;
  final int defaultCurrencyId;
  final String defaultCurrencyCode;
  final String invoicePrefix;
}

class SettingsCurrencyEntity {
  const SettingsCurrencyEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  final int id;
  final String code;
  final String nameAr;
  final String nameEn;
}

class CompanySettingsFormEntity {
  const CompanySettingsFormEntity({
    required this.companyNameAr,
    required this.companyNameEn,
    required this.defaultCurrencyId,
    required this.invoicePrefix,
  });

  final String companyNameAr;
  final String companyNameEn;
  final int defaultCurrencyId;
  final String invoicePrefix;

  Map<String, dynamic> toJson() => {
    'companyNameAr': companyNameAr,
    'companyNameEn': companyNameEn,
    'defaultCurrencyId': defaultCurrencyId,
    'invoicePrefix': invoicePrefix,
  };
}
