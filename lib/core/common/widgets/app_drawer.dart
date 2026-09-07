import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_brand_header.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_navigation_item.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_section_label.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/drawer_user_card.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/login_view.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/home_view.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/create_invoice_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.selectedRoute, super.key});

  final String selectedRoute;

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);

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
                  DrawerSectionLabel(label: translations.account),
                  DrawerNavigationItem(
                    icon: Icons.settings_outlined,
                    label: translations.settings,
                    onTap: () => Navigator.pop(context),
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
}
