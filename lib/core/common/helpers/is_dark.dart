import 'package:flutter/material.dart';

bool isDarkFun(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
