import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/services/secure_storage_service.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/auth/data/models/user_model.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiClient apiClient;
  final SecureStorageService secureStorage;

  AuthRepoImpl({required this.apiClient, required this.secureStorage});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        endPoint: EndPoints.login,
        data: {'username': username, 'password': password},
      );

      final userModel = UserModel.fromJson(response);
      final user = userModel.toEntity();
      await saveUserToLocalStorage(user);

      return Right(user);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    Failure? failure;

    try {
      final refreshToken = await secureStorage.read(kRefreshToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await apiClient.post(
          endPoint: EndPoints.logout,
          data: {'refreshToken': refreshToken},
        );
      }
    } on ServerFailure catch (error) {
      failure = error;
    } on DioException catch (e) {
      failure = ServerFailure.fromDioException(e);
    } catch (_) {
      failure = ServerFailure('Unexpected Error, Please try again later');
    } finally {
      await clearLocalSession();
    }

    return failure == null ? const Right(unit) : Left(failure);
  }

  @override
  Future<Either<Failure, UserEntity>> refreshSession() async {
    try {
      final refreshToken = await secureStorage.read(kRefreshToken);
      if (refreshToken == null || refreshToken.isEmpty) {
        await clearLocalSession();
        return Left(
          ServerFailure('Your session has expired. Please sign in again.'),
        );
      }

      final response = await apiClient.post(
        endPoint: EndPoints.refresh,
        data: {'refreshToken': refreshToken},
      );
      final user = UserModel.fromJson(response).toEntity();
      await saveUserToLocalStorage(user);
      return Right(user);
    } on ServerFailure catch (failure) {
      await clearLocalSession();
      return Left(failure);
    } on DioException catch (e) {
      await clearLocalSession();
      return Left(ServerFailure.fromDioException(e));
    } catch (_) {
      await clearLocalSession();
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<bool> restoreSession() async {
    final user = await _readStoredUser();
    if (user == null) {
      await clearLocalSession();
      return false;
    }

    final now = DateTime.now().toUtc();
    if (user.expiresAt.toUtc().isAfter(now)) return true;

    if (!user.refreshTokenExpiresAt.toUtc().isAfter(now)) {
      await clearLocalSession();
      return false;
    }

    final result = await refreshSession();
    return result.isRight();
  }

  @override
  Future<void> saveUserToLocalStorage(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final encodedUser = jsonEncode(userModel.toLocalJson());
      await secureStorage.write(key: kAccessToken, value: user.token);
      await secureStorage.write(key: kRefreshToken, value: user.refreshToken);
      await Prefs.setString(kUserData, encodedUser);
    } catch (_) {
      await clearLocalSession();
      throw Exception('Failed to save user to local storage');
    }
  }

  @override
  Future<void> clearLocalSession() async {
    await Future.wait([
      Prefs.remove(kUserData),
      secureStorage.delete(kAccessToken),
      secureStorage.delete(kRefreshToken),
    ]);
  }

  Future<UserEntity?> _readStoredUser() async {
    final encodedUser = Prefs.getString(kUserData);
    if (encodedUser.isEmpty) return null;

    try {
      final json = jsonDecode(encodedUser) as Map<String, dynamic>;
      final accessToken = await secureStorage.read(kAccessToken);
      final refreshToken = await secureStorage.read(kRefreshToken);
      if (accessToken == null ||
          accessToken.isEmpty ||
          refreshToken == null ||
          refreshToken.isEmpty) {
        return null;
      }

      return UserModel.fromLocalJson(
        json,
        token: accessToken,
        refreshToken: refreshToken,
      ).toEntity();
    } catch (_) {
      return null;
    }
  }
}
