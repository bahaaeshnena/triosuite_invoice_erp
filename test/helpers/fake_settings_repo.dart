import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/repo/settings_repo.dart';

class FakeSettingsRepo implements SettingsRepo {
  static const settings = CompanySettingsEntity(
    id: 1,
    companyNameAr: 'شركة تريو',
    companyNameEn: 'Trio Company',
    defaultCurrencyId: 1,
    defaultCurrencyCode: 'JOD',
    invoicePrefix: 'INV',
  );

  static const currencies = [
    SettingsCurrencyEntity(
      id: 1,
      code: 'JOD',
      nameAr: 'دينار أردني',
      nameEn: 'Jordanian Dinar',
    ),
  ];

  @override
  Future<Either<Failure, CompanySettingsEntity>> getSettings() async =>
      const Right(settings);

  @override
  Future<Either<Failure, List<SettingsCurrencyEntity>>> getCurrencies() async =>
      const Right(currencies);

  @override
  Future<Either<Failure, CompanySettingsEntity>> updateSettings(
    CompanySettingsFormEntity settings,
  ) async => Right(
    CompanySettingsEntity(
      id: 1,
      companyNameAr: settings.companyNameAr,
      companyNameEn: settings.companyNameEn,
      defaultCurrencyId: settings.defaultCurrencyId,
      defaultCurrencyCode: 'JOD',
      invoicePrefix: settings.invoicePrefix,
    ),
  );
}
