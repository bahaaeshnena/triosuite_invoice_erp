import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  void login({required String username, required String password}) async {
    emit(LoginLoading());
    final result = await authRepo.login(username: username, password: password);
    result.fold(
      (failure) => emit(LoginFailure(failure: failure)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

  void logout({required String refreshToken}) async {
    emit(LogoutLoading());
    final result = await authRepo.logout(refreshToken: refreshToken);
    result.fold(
      (failure) => emit(LogoutFailure(failure: failure)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
