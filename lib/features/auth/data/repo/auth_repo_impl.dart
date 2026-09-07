import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/auth/data/models/user_model.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiClient apiClient;

  AuthRepoImpl({required this.apiClient});
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

      return Right(userModel.toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout({required String refreshToken}) async {
    try {
      await apiClient.post(
        endPoint: EndPoints.logout,
        data: {'refreshToken': refreshToken},
      );

      return const Right(unit);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<void> saveUserToLocalStorage(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final encodedUser = jsonEncode(userModel.toJson());
      await Prefs.setString(kUserData, encodedUser);
    } catch (e) {
      throw Exception('Failed to save user to local storage');
    }
  }
}
