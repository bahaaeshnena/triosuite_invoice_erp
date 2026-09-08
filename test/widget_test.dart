// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_text_style.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_theme.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/main.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';
import 'helpers/fake_invoice_repo.dart';

void main() {
  setUpAll(() async {
    setupServiceLocator();
    await getIt.unregister<InvoiceRepo>();
    getIt.registerLazySingleton<InvoiceRepo>(FakeInvoiceRepo.new);
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Prefs.init();
  });

  testWidgets('app starts successfully', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('drawer changes and saves language and theme', (tester) async {
    await Prefs.setString(
      kUserData,
      jsonEncode({
        'token': 'token',
        'refreshToken': 'refresh-token',
        'expiresAt': '2026-09-08T12:00:00.000Z',
        'refreshTokenExpiresAt': '2026-10-08T12:00:00.000Z',
        'id': 7,
        'username': 'ahmad',
        'fullNameAr': 'أحمد الخطيب',
        'fullNameEn': 'Ahmad Al-Khatib',
      }),
    );

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    Navigator.of(
      tester.element(find.byType(LoginView)),
    ).pushNamed(HomeView.routeName);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.text('Company settings'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Dark mode'), findsOneWidget);
    expect(find.text('Ahmad Al-Khatib'), findsOneWidget);
    expect(find.text('@ahmad'), findsOneWidget);

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arabic'));
    await tester.pumpAndSettle();

    expect(Prefs.getString(kAppLanguageCode), 'ar');
    expect(find.text('أحمد الخطيب'), findsOneWidget);
    expect(find.text('إعدادات الشركة'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(Prefs.getBool(kIsDarkMode), isTrue);
    expect(
      Theme.of(tester.element(find.byType(HomeView))).brightness,
      Brightness.dark,
    );
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
