import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsActions extends StatelessWidget {
  const InvoiceDetailsActions({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final downloadButton = FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_rounded),
          label: Text(translations.downloadPdf),
        );
        final sendButton = OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send_outlined),
          label: Text(translations.sendInvoice),
        );

        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [downloadButton, const SizedBox(height: 10), sendButton],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [sendButton, const SizedBox(width: 12), downloadButton],
        );
      },
    );
  }
}
