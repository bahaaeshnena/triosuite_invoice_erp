import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_colors.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_text_style.dart';

abstract final class AppTheme {
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;

  static ThemeData light({Locale locale = const Locale('en')}) =>
      _build(Brightness.light, locale);

  static ThemeData dark({Locale locale = const Locale('en')}) =>
      _build(Brightness.dark, locale);

  /// Rebuilds typography for the active locale while preserving brightness.
  static ThemeData forLocale(
    Locale locale, {
    Brightness brightness = Brightness.light,
  }) => _build(brightness, locale);

  static ThemeData _build(Brightness brightness, Locale locale) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? const Color(0xFF93C5FD) : AppColors.primary,
      onPrimary: isDark ? const Color(0xFF172554) : AppColors.white,
      primaryContainer: isDark
          ? const Color(0xFF1E3A8A)
          : AppColors.primaryLight,
      onPrimaryContainer: isDark
          ? const Color(0xFFDBEAFE)
          : AppColors.primaryDark,
      secondary: isDark ? const Color(0xFF5EEAD4) : AppColors.secondary,
      onSecondary: isDark ? const Color(0xFF042F2E) : AppColors.white,
      secondaryContainer: isDark
          ? const Color(0xFF134E4A)
          : AppColors.secondaryLight,
      onSecondaryContainer: isDark
          ? const Color(0xFFCCFBF1)
          : AppColors.secondary,
      error: isDark ? const Color(0xFFFCA5A5) : AppColors.error,
      onError: isDark ? const Color(0xFF450A0A) : AppColors.white,
      errorContainer: isDark
          ? const Color(0xFF7F1D1D)
          : AppColors.errorContainer,
      onErrorContainer: isDark ? const Color(0xFFFEE2E2) : AppColors.error,
      surface: isDark ? AppColors.darkSurface : AppColors.surface,
      onSurface: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
      surfaceContainerHighest: isDark
          ? AppColors.darkSurfaceVariant
          : AppColors.surfaceVariant,
      onSurfaceVariant: isDark
          ? AppColors.darkTextSecondary
          : AppColors.textSecondary,
      outline: isDark ? AppColors.darkBorder : AppColors.border,
      outlineVariant: isDark ? AppColors.darkDivider : AppColors.divider,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: isDark ? AppColors.surface : AppColors.darkSurface,
      onInverseSurface: isDark
          ? AppColors.textPrimary
          : AppColors.darkTextPrimary,
      inversePrimary: isDark ? AppColors.primary : const Color(0xFF93C5FD),
    );
    final textTheme = AppTextStyle.textTheme(
      locale: locale,
      color: colorScheme.onSurface,
    );
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radiusMedium),
      borderSide: BorderSide(color: colorScheme.outline),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.background,
      fontFamily: AppTextStyle.fontFamilyFor(locale),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: AppColors.transparent,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surface,
        surfaceTintColor: AppColors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        border: border,
        enabledBorder: border,
        disabledBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.outlineVariant,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          minimumSize: const Size(64, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(64, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      dialogTheme: DialogThemeData(
        elevation: 6,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: AppColors.transparent,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: AppColors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: textTheme.labelLarge,
        dataTextStyle: textTheme.bodyMedium,
        headingRowColor: WidgetStatePropertyAll(
          colorScheme.surfaceContainerHighest,
        ),
        dividerThickness: 1,
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primaryContainer,
        circularTrackColor: colorScheme.primaryContainer,
      ),
    );
  }
}
