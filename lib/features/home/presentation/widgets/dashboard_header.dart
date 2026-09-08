import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return FilledButton.icon(
      onPressed: () =>
          Navigator.pushNamed(context, CreateInvoiceView.routeName),
      icon: const Icon(Icons.add_rounded),
      label: Text(translations.createInvoice),
    );
  }
}
