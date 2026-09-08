import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:triosuite_invoice_erp/core/common/helpers/on_generate_routes.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_theme.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/repo/settings_repo.dart';
import 'package:triosuite_invoice_erp/features/settings/presentation/company_settings_view.dart';
import 'helpers/fake_invoice_repo.dart';
import 'helpers/fake_settings_repo.dart';

void main() {
  setUpAll(() async {
    setupServiceLocator();
    await getIt.unregister<InvoiceRepo>();
    getIt.registerLazySingleton<InvoiceRepo>(FakeInvoiceRepo.new);
    await getIt.unregister<SettingsRepo>();
    getIt.registerLazySingleton<SettingsRepo>(FakeSettingsRepo.new);
  });

  testWidgets('invoice UI routes render on a mobile viewport', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const InvoiceTestApp(initialRoute: HomeView.routeName),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeView), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(tester.takeException(), isNull);

    Navigator.of(tester.element(find.byType(HomeView))).pop();
    await tester.pumpAndSettle();
    Navigator.of(
      tester.element(find.byType(HomeView)),
    ).pushNamed(CreateInvoiceView.routeName);
    await tester.pumpAndSettle();
    expect(find.byType(CreateInvoiceView), findsOneWidget);
    expect(tester.takeException(), isNull);

    Navigator.of(
      tester.element(find.byType(CreateInvoiceView)),
    ).pushNamed(InvoiceDetailsView.routeName);
    await tester.pumpAndSettle();
    expect(find.byType(InvoiceDetailsView), findsOneWidget);
    expect(tester.takeException(), isNull);

    Navigator.of(
      tester.element(find.byType(InvoiceDetailsView)),
    ).pushNamed(CompanySettingsView.routeName);
    await tester.pumpAndSettle();
    expect(find.byType(CompanySettingsView), findsOneWidget);
    expect(find.text('Trio Company'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('invoice UI supports Arabic direction and translations', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const InvoiceTestApp(
        initialRoute: HomeView.routeName,
        locale: Locale('ar'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الفواتير'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(HomeView))),
      TextDirection.rtl,
    );
    expect(tester.takeException(), isNull);

    Navigator.of(
      tester.element(find.byType(HomeView)),
    ).pushNamed(CreateInvoiceView.routeName);
    await tester.pumpAndSettle();
    expect(find.text('بيانات العميل'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class InvoiceTestApp extends StatelessWidget {
  const InvoiceTestApp({
    required this.initialRoute,
    this.locale = const Locale('en'),
    super.key,
  });

  final String initialRoute;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      theme: AppTheme.light(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoutes,
    );
  }
}
