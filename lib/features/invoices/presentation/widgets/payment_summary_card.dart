import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/total_row.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class PaymentSummaryCard extends StatelessWidget {
  const PaymentSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return InvoiceSectionCard(
      title: translations.paymentSummary,
      icon: Icons.account_balance_wallet_outlined,
      child: Column(
        children: [
          TotalRow(
            label: translations.subtotal,
            value: '10,000 ${translations.sar}',
          ),
          const SizedBox(height: 10),
          TotalRow(
            label: '${translations.taxAmount} (15%)',
            value: '1,500 ${translations.sar}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Divider(),
          ),
          TotalRow(
            label: translations.grandTotal,
            value: '11,500 ${translations.sar}',
            isEmphasized: true,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest.withValues(alpha: .6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.account_balance_outlined, color: colors.primary),
                const SizedBox(width: 10),
                Expanded(child: Text(translations.paymentMethod)),
                Text(
                  translations.bankTransfer,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
