import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/invoice_status_badge.dart';
import 'package:triosuite_invoice_erp/core/common/widgets/section_title.dart';
import 'package:triosuite_invoice_erp/features/home/presentation/widgets/recent_invoice_list_item.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/cubit/invoice_list_cubit.dart';
import 'package:triosuite_invoice_erp/features/invoices/presentation/invoice_details_view.dart';
import 'package:triosuite_invoice_erp/generated/l10n.dart';

class RecentInvoicesSection extends StatelessWidget {
  const RecentInvoicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          title: tr.invoices,
          action: IconButton(
            tooltip: tr.refresh,
            onPressed: context.read<InvoiceListCubit>().load,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<InvoiceListCubit, InvoiceListState>(
          builder: (context, state) {
            if (state is InvoiceListLoading || state is InvoiceListInitial) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is InvoiceListFailure) {
              return _MessageCard(
                message: state.failure.message,
                actionLabel: tr.retry,
                onAction: context.read<InvoiceListCubit>().load,
              );
            }
            final invoices = (state as InvoiceListSuccess).invoices;
            if (invoices.isEmpty) {
              return _MessageCard(message: tr.noInvoices);
            }
            final isArabic =
                Localizations.localeOf(context).languageCode == 'ar';
            final locale = Localizations.localeOf(context).toString();
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var index = 0; index < invoices.length; index++) ...[
                    RecentInvoiceListItem(
                      invoiceNumber: '#${invoices[index].invoiceNumber}',
                      customerName: isArabic
                          ? invoices[index].customerNameAr
                          : invoices[index].customerNameEn,
                      date: DateFormat.yMd(
                        locale,
                      ).format(invoices[index].invoiceDate),
                      amount:
                          '${invoices[index].totalAmount.toStringAsFixed(3)} ${invoices[index].currencyCode}',
                      status: invoiceStatusFromCode(invoices[index].status),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          InvoiceDetailsView.routeName,
                          arguments: invoices[index].id,
                        );
                        if (context.mounted) {
                          context.read<InvoiceListCubit>().load();
                        }
                      },
                    ),
                    if (index < invoices.length - 1) const Divider(),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.message, this.actionLabel, this.onAction});

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 10),
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
