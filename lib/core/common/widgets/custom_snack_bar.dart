import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_colors.dart';

enum SnackBarType { success, error, warning, info }

abstract final class CustomSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool clearPrevious = true,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final colors = _colors(type);

    if (clearPrevious) {
      messenger.hideCurrentSnackBar();
    }

    return messenger.showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: colors.background,
        dismissDirection: DismissDirection.horizontal,
        content: Row(
          children: [
            Icon(_icon(type), color: colors.foreground, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        action: actionLabel == null || onActionPressed == null
            ? null
            : SnackBarAction(
                label: actionLabel,
                textColor: colors.foreground,
                onPressed: onActionPressed,
              ),
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message,
  ) => show(context, message: message, type: SnackBarType.success);

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message,
  ) => show(context, message: message, type: SnackBarType.error);

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warning(
    BuildContext context,
    String message,
  ) => show(context, message: message, type: SnackBarType.warning);

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context,
    String message,
  ) => show(context, message: message, type: SnackBarType.info);

  static IconData _icon(SnackBarType type) => switch (type) {
    SnackBarType.success => Icons.check_circle_rounded,
    SnackBarType.error => Icons.error_rounded,
    SnackBarType.warning => Icons.warning_amber_rounded,
    SnackBarType.info => Icons.info_rounded,
  };

  static _SnackBarColors _colors(SnackBarType type) => switch (type) {
    SnackBarType.success => const _SnackBarColors(
      background: AppColors.success,
      foreground: AppColors.white,
    ),
    SnackBarType.error => const _SnackBarColors(
      background: AppColors.error,
      foreground: AppColors.white,
    ),
    SnackBarType.warning => const _SnackBarColors(
      background: AppColors.warningContainer,
      foreground: Color(0xFF78350F),
    ),
    SnackBarType.info => const _SnackBarColors(
      background: AppColors.info,
      foreground: AppColors.white,
    ),
  };
}

final class _SnackBarColors {
  const _SnackBarColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
