import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/activity_timeline_item.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceActivityCard extends StatelessWidget {
  const InvoiceActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.activity,
      icon: Icons.history_rounded,
      child: Column(
        children: [
          ActivityTimelineItem(
            title: translations.paymentReceived,
            date: '19/06/2025 • 10:30',
            icon: Icons.check_rounded,
            isLast: false,
          ),
          ActivityTimelineItem(
            title: translations.invoiceCreated,
            date: '18/06/2025 • 09:15',
            icon: Icons.add_rounded,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
