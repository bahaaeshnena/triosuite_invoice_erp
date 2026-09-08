import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_navigation_item.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_section_label.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_user_card.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';
import 'package:triosuite_invoice_erp/main.dart';
import 'package:triosuite_invoice_erp/features/settings/presentation/company_settings_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.selectedRoute, super.key});

  final String selectedRoute;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    final app = MyApp.maybeOf(context);
    final isDarkMode =
        app?.isDarkMode ?? Theme.of(context).brightness == Brightness.dark;
    final isLoggingOut = context.watch<AuthCubit>().state is LogoutLoading;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, state) =>
          state is LogoutSuccess || state is LogoutFailure,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginView.routeName,
          (_) => false,
        );
      },
      child: Drawer(
        width: 304,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.horizontal(
            end: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 10),
                child: DrawerUserCard(),
              ),
              const Divider(height: 1),
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

                    const SizedBox(height: 14),
                    DrawerSectionLabel(label: translations.settings),
                    DrawerNavigationItem(
                      icon: Icons.business_outlined,
                      label: translations.companySettings,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          CompanySettingsView.routeName,
                        );
                      },
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
                child: IgnorePointer(
                  ignoring: isLoggingOut,
                  child: DrawerNavigationItem(
                    icon: isLoggingOut
                        ? Icons.hourglass_top_rounded
                        : Icons.logout_rounded,
                    label: translations.logout,
                    isDestructive: true,
                    onTap: () => context.read<AuthCubit>().logout(),
                  ),
                ),
              ),
            ],
          ),
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
