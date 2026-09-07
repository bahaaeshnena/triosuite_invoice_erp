import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_input_field.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceLineItem extends StatelessWidget {
  const InvoiceLineItem({
    required this.index,
    required this.onDelete,
    super.key,
  });

  final int index;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final colors = Theme.of(context).colorScheme;
    final itemName = index == 0
        ? translations.itemLaptop
        : translations.itemSupport;
    final price = index == 0 ? '8,500' : '1,500';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: .38),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 10,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: constraints.maxWidth >= 720
                    ? constraints.maxWidth * .34
                    : constraints.maxWidth,
                child: InvoiceInputField(
                  label: translations.item,
                  initialValue: itemName,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 720 ? 110 : 130,
                child: InvoiceInputField(
                  label: translations.quantity,
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 720 ? 150 : 160,
                child: InvoiceInputField(
                  label: translations.price,
                  initialValue: price,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth >= 720 ? 110 : 130,
                child: InvoiceInputField(
                  label: translations.tax,
                  initialValue: '15%',
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
                onPressed: onDelete,
                color: colors.error,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          );
        },
      ),
    );
  }
}
