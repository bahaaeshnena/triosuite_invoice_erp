import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/create_invoice_view_body.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});

  static const String routeName = 'create_invoice_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).createInvoice)),
      body: const CreateInvoiceViewBody(),
    );
  }
}
