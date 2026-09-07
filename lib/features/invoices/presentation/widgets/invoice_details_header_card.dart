import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/invoice_status_badge.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_meta_item.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsHeaderCard extends StatelessWidget {
  const InvoiceDetailsHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, const Color(0xFF174AA8)],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: .22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.invoiceNumber,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: .76),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '#INV-2025-0084',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
              const InvoiceStatusBadge(status: InvoiceStatus.paid),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 30,
            runSpacing: 16,
            children: [
              InvoiceMetaItem(
                icon: Icons.calendar_today_outlined,
                label: translations.issuedOn,
                value: '18/06/2025',
                useLightColors: true,
              ),
              InvoiceMetaItem(
                icon: Icons.event_available_outlined,
                label: translations.dueOn,
                value: '18/07/2025',
                useLightColors: true,
              ),
              InvoiceMetaItem(
                icon: Icons.payments_outlined,
                label: translations.grandTotal,
                value: '11,500 ${translations.sar}',
                useLightColors: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
