import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/total_row.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceTotalsCard extends StatelessWidget {
  const InvoiceTotalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.primaryContainer.withValues(alpha: .55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.primary.withValues(alpha: .18)),
          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
