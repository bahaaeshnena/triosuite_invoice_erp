part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserEntity user;

  LoginSuccess({required this.user});
}

final class LoginFailure extends AuthState {
  final Failure failure;

  LoginFailure({required this.failure});
}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {
  final Failure failure;

  LogoutFailure({required this.failure});
}
