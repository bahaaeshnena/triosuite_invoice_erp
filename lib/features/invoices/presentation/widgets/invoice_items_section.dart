import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_line_item.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceItemsSection extends StatefulWidget {
  const InvoiceItemsSection({super.key});

  @override
  State<InvoiceItemsSection> createState() => _InvoiceItemsSectionState();
}

class _InvoiceItemsSectionState extends State<InvoiceItemsSection> {
  int itemCount = 2;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.invoiceItems,
      icon: Icons.inventory_2_outlined,
      trailing: TextButton.icon(
        onPressed: () => setState(() => itemCount++),
        icon: const Icon(Icons.add_rounded, size: 18),
        label: Text(translations.addItem),
      ),
      child: Column(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: index == itemCount - 1 ? 0 : 14),
            child: InvoiceLineItem(
              index: index,
              onDelete: itemCount <= 1
                  ? null
                  : () => setState(() => itemCount--),
            ),
          ),
        ),
      ),
    );
  }
}
