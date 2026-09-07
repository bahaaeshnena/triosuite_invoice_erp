import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoicePartyCard extends StatelessWidget {
  const InvoicePartyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return InvoiceSectionCard(
      title: translations.billTo,
      icon: Icons.business_outlined,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: colors.secondaryContainer,
            foregroundColor: colors.onSecondaryContainer,
            child: const Icon(Icons.business_center_outlined),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations.sampleCustomerDigitalHorizon,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'billing@ofoq.co',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                Text(
                  '+966 50 123 4567',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${translations.taxNumber}: 310123456700003',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
