import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_details_view_body.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsView extends StatelessWidget {
  const InvoiceDetailsView({super.key});

  static const String routeName = 'invoice_details_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).invoiceDetailsTitle),
        actions: [
          IconButton(
            tooltip: S.of(context).printInvoice,
            onPressed: () {},
            icon: const Icon(Icons.print_outlined),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: const InvoiceDetailsViewBody(),
    );
  }
}
