import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CreateInvoiceActions extends StatelessWidget {
  const CreateInvoiceActions({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final primaryButton = FilledButton.icon(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            InvoiceDetailsView.routeName,
          ),
          icon: const Icon(Icons.check_rounded),
          label: Text(translations.issueInvoice),
        );
        final secondaryButton = OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.save_outlined),
          label: Text(translations.saveDraft),
        );

        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              primaryButton,
              const SizedBox(height: 10),
              secondaryButton,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [secondaryButton, const SizedBox(width: 12), primaryButton],
        );
      },
    );
  }
}
