import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/create_invoice_cubit.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/create_invoice_view_body.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});

  static const String routeName = 'create_invoice_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CreateInvoiceCubit(invoiceRepo: getIt<InvoiceRepo>())..loadLookups(),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).createInvoice)),
        body: const CreateInvoiceViewBody(),
      ),
    );
  }
}
