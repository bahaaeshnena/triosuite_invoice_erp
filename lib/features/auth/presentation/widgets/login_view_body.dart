import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_background.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_form_card.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: LoginBackground()),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 44,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LoginHeader(),
                      SizedBox(height: 30),
                      LoginFormCard(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
