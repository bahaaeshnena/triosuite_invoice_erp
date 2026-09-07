import 'package:flutter/material.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/app_drawer.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/home_app_bar.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      drawer: AppDrawer(selectedRoute: routeName),
      body: HomeViewBody(),
    );
  }
}
