import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';
import 'package:triosuite_invoice_erp/features/settings/presentation/company_settings_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginView(),
      );
    case HomeView.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeView(),
      );
    case CreateInvoiceView.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CreateInvoiceView(),
      );
    case InvoiceDetailsView.routeName:
      final invoiceId = settings.arguments as int? ?? 0;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => InvoiceDetailsView(invoiceId: invoiceId),
      );
    case CompanySettingsView.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CompanySettingsView(),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) =>
            Scaffold(body: Center(child: Text(S.of(context).noRouteDefined))),
      );
  }
}
