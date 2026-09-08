import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';

abstract class SettingsRepo {
  Future<Either<Failure, CompanySettingsEntity>> getSettings();

  Future<Either<Failure, List<SettingsCurrencyEntity>>> getCurrencies();

  Future<Either<Failure, CompanySettingsEntity>> updateSettings(
    CompanySettingsFormEntity settings,
  );
}
