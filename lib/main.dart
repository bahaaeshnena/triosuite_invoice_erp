import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:triosuite_invoice_erp/core/common/helpers/on_generate_routes.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/theme/app_theme.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  static MyAppState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>();
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late ThemeMode themeMode;
  late Locale _locale;

  Locale get locale => _locale;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  @override
  void initState() {
    super.initState();

    themeMode = Prefs.getBool(kIsDarkMode) ? ThemeMode.dark : ThemeMode.light;

    final savedLanguageCode = Prefs.getString(kAppLanguageCode);
    _locale = Locale(savedLanguageCode.isEmpty ? 'en' : savedLanguageCode);
  }

  void changeTheme(bool isDark) {
    if (isDarkMode == isDark) return;

    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
    Prefs.setBool(kIsDarkMode, isDark);
  }

  void changeLanguage(String code) {
    if (_locale.languageCode == code) return;

    setState(() => _locale = Locale(code));
    Prefs.setString(kAppLanguageCode, code);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      theme: AppTheme.light(locale: locale),
      darkTheme: AppTheme.dark(locale: locale),
      themeMode: themeMode,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateRoute: onGenerateRoutes,
      home: const LoginView(),
    );
  }
}
