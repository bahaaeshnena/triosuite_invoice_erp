import 'dart:convert';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/features/auth/data/models/user_model.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';

UserEntity? getUser() {
  final jsonString = Prefs.getString(kUserData);

  if (jsonString.isEmpty) {
    return null;
  }

  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  return UserModel.fromJson(json).toEntity();
}
