import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/custom_text_form_field.dart';
import 'package:triosuite_invoice_erp/core/utils/validations/validators.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.onSaved});

  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: S.of(context).passwordHint,
      textInputAction: TextInputAction.done,
      obscureText: _obscurePassword,
      enableSuggestions: false,
      autocorrect: false,
      prefixIcon: const Icon(Icons.lock_outline_rounded, size: 21),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() => _obscurePassword = !_obscurePassword);
        },
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 21,
        ),
      ),
      validator: (value) => Validators.validatePassword(value, context),
      onSaved: widget.onSaved,
    );
  }
}
