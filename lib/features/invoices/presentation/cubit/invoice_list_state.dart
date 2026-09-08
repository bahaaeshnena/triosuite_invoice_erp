part of 'invoice_list_cubit.dart';

@immutable
sealed class InvoiceListState {}

final class InvoiceListInitial extends InvoiceListState {}

final class InvoiceListLoading extends InvoiceListState {}

final class InvoiceListSuccess extends InvoiceListState {
  InvoiceListSuccess(this.invoices);
  final List<InvoiceSummaryEntity> invoices;
}

final class InvoiceListFailure extends InvoiceListState {
  InvoiceListFailure(this.failure);
  final Failure failure;
}
