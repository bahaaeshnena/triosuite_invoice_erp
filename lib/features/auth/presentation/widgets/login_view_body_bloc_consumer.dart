import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_modal_progress_hud.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_snack_bar.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_view_body.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
          CustomSnackBar.show(
            context,
            message: S.of(context).loginSuccess,
            type: SnackBarType.success,
          );
        }

        if (state is LoginFailure) {
          CustomSnackBar.show(
            context,
            message: state.failure.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return CustomModalProgressHud(
          isLoading: state is LoginLoading,
          child: LoginViewBody(),
        );
      },
    );
  }
}
