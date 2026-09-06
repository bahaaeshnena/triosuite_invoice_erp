import 'package:flutter/material.dart';

abstract final class AppTextStyle {
  static const String arabicFontFamily = 'NotoKufiArabic';
  static const String englishFontFamily = 'Inter';

  static bool isArabic(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar';

  static String fontFamilyFor(Locale locale) =>
      isArabic(locale) ? arabicFontFamily : englishFontFamily;

  static String fontFamilyOf(BuildContext context) =>
      fontFamilyFor(Localizations.localeOf(context));

  static TextTheme textTheme({required Locale locale, required Color color}) {
    final family = fontFamilyFor(locale);

    TextStyle style(
      double size,
      FontWeight weight, {
      double? height,
      double? letterSpacing,
    }) {
      return TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size,
        fontWeight: weight,
        height: height ?? (isArabic(locale) ? 1.55 : 1.35),
        letterSpacing: isArabic(locale) ? 0 : letterSpacing,
      );
    }

    return TextTheme(
      displayLarge: style(40, FontWeight.w700, letterSpacing: -0.5),
      displayMedium: style(36, FontWeight.w700, letterSpacing: -0.4),
      displaySmall: style(32, FontWeight.w700, letterSpacing: -0.3),
      headlineLarge: style(28, FontWeight.w700, letterSpacing: -0.2),
      headlineMedium: style(24, FontWeight.w700, letterSpacing: -0.1),
      headlineSmall: style(22, FontWeight.w600),
      titleLarge: style(20, FontWeight.w600),
      titleMedium: style(16, FontWeight.w600),
      titleSmall: style(14, FontWeight.w600),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(14, FontWeight.w400),
      bodySmall: style(12, FontWeight.w400),
      labelLarge: style(14, FontWeight.w600),
      labelMedium: style(12, FontWeight.w600),
      labelSmall: style(11, FontWeight.w500),
    );
  }

  static TextStyle displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge!;
  static TextStyle headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!;
  static TextStyle headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;
  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!;
  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!;
  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!;
  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;
  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;
  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!;
}
