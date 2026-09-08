import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/network/api_service.dart';
import 'package:triosuite_invoice_erp/core/services/secure_storage_service.dart';
import 'package:triosuite_invoice_erp/features/auth/data/repo/auth_repo_impl.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<SecureStorageService>(
    () => const SecureStorageService(FlutterSecureStorage()),
  );
  getIt.registerLazySingleton<ApiClient>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      apiClient: getIt<ApiClient>(),
      secureStorage: getIt<SecureStorageService>(),
    ),
  );
}
