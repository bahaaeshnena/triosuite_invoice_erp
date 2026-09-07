import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_input_field.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceNotesSection extends StatelessWidget {
  const InvoiceNotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.notes,
      icon: Icons.notes_rounded,
      child: InvoiceInputField(
        label: translations.notes,
        hint: translations.notesHint,
        maxLines: 3,
      ),
    );
  }
}
