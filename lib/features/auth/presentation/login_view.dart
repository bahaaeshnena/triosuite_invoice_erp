import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_view_body_bloc_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => AuthCubit( authRepo: getIt<AuthRepo>() ),
        child: LoginViewBodyBlocConsumer(),
      ),
    );
  }
}
