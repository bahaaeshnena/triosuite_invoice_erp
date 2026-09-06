import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class LoginSupportHint extends StatelessWidget {
  const LoginSupportHint({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.headset_mic_outlined,
          size: 17,
          color: colors.onSurfaceVariant,
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            S.of(context).supportHint,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
