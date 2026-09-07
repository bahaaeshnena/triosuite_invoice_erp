import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_input_field.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/responsive_field_wrap.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceMetadataSection extends StatelessWidget {
  const InvoiceMetadataSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.invoiceDetails,
      icon: Icons.event_note_outlined,
      child: ResponsiveFieldWrap(
        children: [
          InvoiceInputField(
            label: translations.invoiceNumber,
            initialValue: 'INV-2025-0085',
            prefixIcon: Icons.tag_rounded,
            readOnly: true,
          ),
          InvoiceInputField(
            label: translations.invoiceDate,
            initialValue: '18/06/2025',
            prefixIcon: Icons.calendar_today_outlined,
            readOnly: true,
          ),
          InvoiceInputField(
            label: translations.dueDate,
            initialValue: '18/07/2025',
            prefixIcon: Icons.event_available_outlined,
            readOnly: true,
          ),
          InvoiceInputField(
            label: translations.currency,
            initialValue: translations.sar,
            prefixIcon: Icons.payments_outlined,
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
