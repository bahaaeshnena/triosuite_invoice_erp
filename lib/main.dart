import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_theme.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        final locale = Localizations.localeOf(context);
        final brightness = Theme.of(context).brightness;

        return Theme(
          data: AppTheme.forLocale(locale, brightness: brightness),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const LoginView(),
    );
  }
}
