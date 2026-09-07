import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_detail_item_row.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsItemsCard extends StatelessWidget {
  const InvoiceDetailsItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.invoiceItems,
      icon: Icons.inventory_2_outlined,
      child: Column(
        children: [
          InvoiceDetailItemRow(
            itemName: translations.itemLaptop,
            quantity: '1',
            price: '8,500 ${translations.sar}',
            total: '8,500 ${translations.sar}',
          ),
          const Divider(height: 28),
          InvoiceDetailItemRow(
            itemName: translations.itemSupport,
            quantity: '1',
            price: '1,500 ${translations.sar}',
            total: '1,500 ${translations.sar}',
          ),
        ],
      ),
    );
  }
}
