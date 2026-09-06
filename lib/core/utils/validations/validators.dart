import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class Validators {
  static String? validateEmptyText(
    String? fieldName,
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return S.of(context).isRequired;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).passwordIsRequired;
    }

    return null;
  }
}
