import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/create_invoice_actions.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/create_invoice_header.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/customer_details_section.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_items_section.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_metadata_section.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_notes_section.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_totals_card.dart';

class CreateInvoiceViewBody extends StatelessWidget {
  const CreateInvoiceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 38),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CreateInvoiceHeader(),
                SizedBox(height: 20),
                CustomerDetailsSection(),
                SizedBox(height: 16),
                InvoiceMetadataSection(),
                SizedBox(height: 16),
                InvoiceItemsSection(),
                SizedBox(height: 16),
                InvoiceNotesSection(),
                SizedBox(height: 16),
                InvoiceTotalsCard(),
                SizedBox(height: 20),
                CreateInvoiceActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
