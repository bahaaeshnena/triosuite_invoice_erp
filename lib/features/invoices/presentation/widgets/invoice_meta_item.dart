import 'package:flutter/material.dart';

class InvoiceMetaItem extends StatelessWidget {
  const InvoiceMetaItem({
    required this.icon,
    required this.label,
    required this.value,
    this.useLightColors = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool useLightColors;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final primary = useLightColors ? Colors.white : colors.onSurface;
    final secondary = useLightColors
        ? Colors.white.withValues(alpha: .72)
        : colors.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 19, color: secondary),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: secondary),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
