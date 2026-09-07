import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

enum InvoiceStatus { paid, pending, overdue, draft }

class InvoiceStatusBadge extends StatelessWidget {
  const InvoiceStatusBadge({required this.status, super.key});

  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final (label, foreground, background) = switch (status) {
      InvoiceStatus.paid => (
        translations.paid,
        const Color(0xFF087A55),
        const Color(0xFFE7F8F0),
      ),
      InvoiceStatus.pending => (
        translations.pending,
        const Color(0xFF9A6700),
        const Color(0xFFFFF5D6),
      ),
      InvoiceStatus.overdue => (
        translations.overdue,
        const Color(0xFFC23434),
        const Color(0xFFFFECEC),
      ),
      InvoiceStatus.draft => (
        translations.draft,
        const Color(0xFF526174),
        const Color(0xFFEEF2F6),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
