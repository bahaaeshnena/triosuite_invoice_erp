import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/services/service_locator.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/invoice_details_cubit.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/widgets/invoice_details_view_body.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class InvoiceDetailsView extends StatelessWidget {
  const InvoiceDetailsView({required this.invoiceId, super.key});

  static const String routeName = 'invoice_details_view';
  final int invoiceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          InvoiceDetailsCubit(invoiceRepo: getIt<InvoiceRepo>())
            ..load(invoiceId),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).invoiceDetailsTitle)),
        body: InvoiceDetailsViewBody(invoiceId: invoiceId),
      ),
    );
  }
}
