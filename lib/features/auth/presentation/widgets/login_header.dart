import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/widgets/brand_mark.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return Column(
      children: [
        const BrandMark(),
        const SizedBox(height: 14),
        Text(
          translations.appName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: -.4,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          translations.loginTagline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: .74),
          ),
        ),
      ],
    );
  }
}
