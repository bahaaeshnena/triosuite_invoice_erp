import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_input_field.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_section_card.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/responsive_field_wrap.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CustomerDetailsSection extends StatelessWidget {
  const CustomerDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

    return InvoiceSectionCard(
      title: translations.customerDetails,
      icon: Icons.person_outline_rounded,
      child: ResponsiveFieldWrap(
        children: [
          InvoiceInputField(
            label: translations.customerName,
            hint: translations.customerNameHint,
            initialValue: translations.sampleCustomerDigitalHorizon,
            prefixIcon: Icons.business_outlined,
          ),
          InvoiceInputField(
            label: translations.phoneNumber,
            hint: translations.phoneHint,
            initialValue: '+966 50 123 4567',
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone_outlined,
          ),
          InvoiceInputField(
            label: translations.emailAddress,
            hint: translations.emailHint,
            initialValue: 'billing@ofoq.co',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline_rounded,
          ),
          InvoiceInputField(
            label: translations.taxNumber,
            initialValue: '310123456700003',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.badge_outlined,
          ),
        ],
      ),
    );
  }
}
