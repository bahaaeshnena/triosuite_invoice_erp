import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/invoice_status_badge.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/section_title.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/recent_invoice_list_item.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class RecentInvoicesSection extends StatelessWidget {
  const RecentInvoicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          title: translations.recentInvoices,
          action: TextButton(
            onPressed: () {},
            child: Text(translations.viewAll),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              RecentInvoiceListItem(
                invoiceNumber: '#INV-2025-0084',
                customerName: translations.sampleCustomerDigitalHorizon,
                date: '18/06/2025',
                amount: '12,450 ${translations.sar}',
                status: InvoiceStatus.paid,
                onTap: () =>
                    Navigator.pushNamed(context, InvoiceDetailsView.routeName),
              ),
              const Divider(),
              RecentInvoiceListItem(
                invoiceNumber: '#INV-2025-0083',
                customerName: translations.sampleCustomerModernConstruction,
                date: '17/06/2025',
                amount: '8,920 ${translations.sar}',
                status: InvoiceStatus.pending,
                onTap: () =>
                    Navigator.pushNamed(context, InvoiceDetailsView.routeName),
              ),
              const Divider(),
              RecentInvoiceListItem(
                invoiceNumber: '#INV-2025-0082',
                customerName: translations.sampleCustomerPointOfSale,
                date: '12/06/2025',
                amount: '4,180 ${translations.sar}',
                status: InvoiceStatus.overdue,
                onTap: () =>
                    Navigator.pushNamed(context, InvoiceDetailsView.routeName),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
