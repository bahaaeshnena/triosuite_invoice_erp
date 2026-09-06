// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_text_style.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_theme.dart';
import 'package:triosuite_invoice_erp/main.dart';

void main() {
  testWidgets('app starts successfully', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  test('theme selects the correct font for each locale', () {
    final englishTheme = AppTheme.light();
    final arabicTheme = AppTheme.light(locale: const Locale('ar'));

    expect(
      englishTheme.textTheme.bodyMedium?.fontFamily,
      AppTextStyle.englishFontFamily,
    );
    expect(
      arabicTheme.textTheme.bodyMedium?.fontFamily,
      AppTextStyle.arabicFontFamily,
    );
  });
}
