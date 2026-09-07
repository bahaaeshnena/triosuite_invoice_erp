import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translations.dashboardGreeting,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              translations.dashboardSubtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        );
        final button = FilledButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, CreateInvoiceView.routeName),
          icon: const Icon(Icons.add_rounded),
          label: Text(translations.createInvoice),
        );

        if (constraints.maxWidth < 620) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [content, const SizedBox(height: 18), button],
          );
        }

        return Row(
          children: [
            Expanded(child: content),
            const SizedBox(width: 20),
            button,
          ],
        );
      },
    );
  }
}
