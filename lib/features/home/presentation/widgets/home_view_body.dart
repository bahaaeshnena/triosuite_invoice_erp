import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/dashboard_header.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/recent_invoices_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashboardHeader(),
                SizedBox(height: 26),
                RecentInvoicesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
