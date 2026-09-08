import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/app_drawer.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/repo/auth_repo.dart';
import 'package:triosuite_invoice_erp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/home_app_bar.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/home_view_body.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/invoice_list_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(authRepo: getIt<AuthRepo>())),
        BlocProvider(
          create: (_) =>
              InvoiceListCubit(invoiceRepo: getIt<InvoiceRepo>())..load(),
        ),
      ],
      child: const Scaffold(
        appBar: HomeAppBar(),
        drawer: AppDrawer(selectedRoute: routeName),
        body: HomeViewBody(),
      ),
    );
  }
}
