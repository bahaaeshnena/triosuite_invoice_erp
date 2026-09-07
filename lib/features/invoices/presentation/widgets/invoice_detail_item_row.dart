import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/item_value_column.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailItemRow extends StatelessWidget {
  const InvoiceDetailItemRow({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.total,
    super.key,
  });

  final String itemName;
  final String quantity;
  final String price;
  final String total;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 620) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ItemValueColumn(label: translations.item, value: itemName),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: ItemValueColumn(
                      label: translations.quantity,
                      value: quantity,
                    ),
                  ),
                  Expanded(
                    child: ItemValueColumn(
                      label: translations.price,
                      value: price,
                    ),
                  ),
                  Expanded(
                    child: ItemValueColumn(
                      label: translations.total,
                      value: total,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              flex: 4,
              child: ItemValueColumn(label: translations.item, value: itemName),
            ),
            Expanded(
              child: ItemValueColumn(
                label: translations.quantity,
                value: quantity,
              ),
            ),
            Expanded(
              flex: 2,
              child: ItemValueColumn(label: translations.price, value: price),
            ),
            Expanded(
              flex: 2,
              child: ItemValueColumn(
                label: translations.total,
                value: total,
                isEmphasized: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
