import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_brand_header.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_navigation_item.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_section_label.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_user_card.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';
import 'package:triosuite_invoice_erp/main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.selectedRoute, super.key});

  final String selectedRoute;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final app = MyApp.maybeOf(context);
    final isDarkMode =
        app?.isDarkMode ?? Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 304,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(
          end: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const DrawerBrandHeader(),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  DrawerSectionLabel(label: translations.mainMenu),
                  DrawerNavigationItem(
                    icon: Icons.grid_view_rounded,
                    label: translations.home,
                    isSelected: selectedRoute == HomeView.routeName,
                    onTap: () {
                      if (selectedRoute == HomeView.routeName) {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeView.routeName,
                        (route) => route.settings.name == LoginView.routeName,
                      );
                    },
                  ),
                  DrawerNavigationItem(
                    icon: Icons.receipt_long_outlined,
                    label: translations.invoices,
                    isSelected: selectedRoute == CreateInvoiceView.routeName,
                    onTap: () => Navigator.pushNamed(
                      context,
                      CreateInvoiceView.routeName,
                    ),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.people_alt_outlined,
                    label: translations.customers,
                    onTap: () => Navigator.pop(context),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.inventory_2_outlined,
                    label: translations.products,
                    onTap: () => Navigator.pop(context),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: translations.expenses,
                    onTap: () => Navigator.pop(context),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.bar_chart_rounded,
                    label: translations.reports,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 14),
                  DrawerSectionLabel(label: translations.settings),
                  DrawerNavigationItem(
                    icon: Icons.business_outlined,
                    label: translations.companySettings,
                    onTap: () => Navigator.pop(context),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.language_rounded,
                    label: translations.language,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (app?.locale.languageCode ??
                                      Localizations.localeOf(
                                        context,
                                      ).languageCode) ==
                                  'ar'
                              ? translations.arabic
                              : translations.english,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.expand_more_rounded, size: 18),
                      ],
                    ),
                    onTap: () => _showLanguagePicker(context),
                  ),
                  DrawerNavigationItem(
                    icon: Icons.dark_mode_outlined,
                    label: translations.darkMode,
                    trailing: Switch.adaptive(
                      value: isDarkMode,
                      onChanged: app?.changeTheme,
                    ),
                    onTap: app == null
                        ? () {}
                        : () => app.changeTheme(!app.isDarkMode),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  const DrawerUserCard(),
                  const SizedBox(height: 8),
                  DrawerNavigationItem(
                    icon: Icons.logout_rounded,
                    label: translations.logout,
                    isDestructive: true,
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginView.routeName,
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final translations = S.of(context);
    final app = MyApp.maybeOf(context);
    final selectedLanguage =
        app?.locale.languageCode ??
        Localizations.localeOf(context).languageCode;
    final languageCode = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                translations.selectLanguage,
                style: Theme.of(
                  sheetContext,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              _LanguageOption(
                label: translations.arabic,
                languageCode: 'ar',
                selectedLanguage: selectedLanguage,
              ),
              _LanguageOption(
                label: translations.english,
                languageCode: 'en',
                selectedLanguage: selectedLanguage,
              ),
            ],
          ),
        ),
      ),
    );

    if (languageCode != null && context.mounted) {
      MyApp.maybeOf(context)?.changeLanguage(languageCode);
    }
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.languageCode,
    required this.selectedLanguage,
  });

  final String label;
  final String languageCode;
  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final isSelected = languageCode == selectedLanguage;

    return ListTile(
      leading: Icon(
        isSelected
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () => Navigator.pop(context, languageCode),
    );
  }
}
