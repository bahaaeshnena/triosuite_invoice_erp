import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: LoginViewBody(),
    );
  }
}
