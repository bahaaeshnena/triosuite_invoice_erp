import 'package:flutter/material.dart';

class InvoiceInputField extends StatelessWidget {
  const InvoiceInputField({
    required this.label,
    this.hint,
    this.initialValue,
    this.prefixIcon,
    this.suffixText,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    super.key,
  });

  final String label;
  final String? hint;
  final String? initialValue;
  final IconData? prefixIcon;
  final String? suffixText;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, size: 20),
        suffixText: suffixText,
      ),
    );
  }
}
