import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, Unit>> logout({required String refreshToken});

  Future<void> saveUserToLocalStorage(UserEntity user);
}
