import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_elevated_button.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_text_form_field.dart';
import 'package:triosuite_invoice_erp/core/utils/validations/validators.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/login_field_label.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/password_field.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({super.key});

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String username, password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final translations = S.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .65)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102A5E).withValues(alpha: .10),
            blurRadius: 34,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              translations.welcomeBack,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              translations.loginSubtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 26),
            LoginFieldLabel(text: translations.username),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintText: translations.usernameHint,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.person_outline_outlined, size: 21),
              autocorrect: false,
              validator: (value) => Validators.validateEmptyText(
                translations.username,
                value,
                context,
              ),
              onSaved: (value) {
                username = value!;
              },
            ),
            const SizedBox(height: 18),
            LoginFieldLabel(text: translations.password),
            const SizedBox(height: 8),
            PasswordField(
              onSaved: (value) {
                password = value!;
              },
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              height: 54,
              text: translations.signIn,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<AuthCubit>().login(
                    username: username,
                    password: password,
                  );
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
