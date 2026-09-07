import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_activity_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_details_actions.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_details_header_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_details_items_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_party_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/payment_summary_card.dart';

class InvoiceDetailsViewBody extends StatelessWidget {
  const InvoiceDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 38),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InvoiceDetailsHeaderCard(),
                SizedBox(height: 16),
                InvoicePartyCard(),
                SizedBox(height: 16),
                InvoiceDetailsItemsCard(),
                SizedBox(height: 16),
                PaymentSummaryCard(),
                SizedBox(height: 16),
                InvoiceActivityCard(),
                SizedBox(height: 20),
                InvoiceDetailsActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
