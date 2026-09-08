import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/settings/data/models/company_settings_model.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/repo/settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  const SettingsRepoImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<Failure, CompanySettingsEntity>> getSettings() async {
    try {
      final response = await apiClient.get(endPoint: EndPoints.settings);
      return Right(CompanySettingsModel.fromJson(response).toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, List<SettingsCurrencyEntity>>> getCurrencies() async {
    try {
      final response = await apiClient.get(endPoint: EndPoints.lookups);
      final currencies = response['currencies'] as List<dynamic>? ?? const [];
      return Right(
        currencies.map((value) {
          final item = Map<String, dynamic>.from(value as Map);
          return SettingsCurrencyEntity(
            id: item['id'] as int,
            code: item['code'] as String,
            nameAr: item['nameAr'] as String,
            nameEn: item['nameEn'] as String,
          );
        }).toList(),
      );
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, CompanySettingsEntity>> updateSettings(
    CompanySettingsFormEntity settings,
  ) async {
    try {
      final response = await apiClient.put(
        endPoint: EndPoints.settings,
        data: settings.toJson(),
      );
      return Right(CompanySettingsModel.fromJson(response).toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }
}
