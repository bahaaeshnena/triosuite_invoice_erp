part of 'invoice_details_cubit.dart';

@immutable
sealed class InvoiceDetailsState {}

final class InvoiceDetailsInitial extends InvoiceDetailsState {}

final class InvoiceDetailsLoading extends InvoiceDetailsState {}

final class InvoiceDetailsSuccess extends InvoiceDetailsState {
  InvoiceDetailsSuccess(this.invoice);
  final InvoiceDetailsEntity invoice;
}

final class InvoiceDetailsActionLoading extends InvoiceDetailsSuccess {
  InvoiceDetailsActionLoading(super.invoice);
}

final class InvoiceDetailsLoadFailure extends InvoiceDetailsState {
  InvoiceDetailsLoadFailure(this.failure);
  final Failure failure;
}

final class InvoiceDetailsActionFailure extends InvoiceDetailsSuccess {
  InvoiceDetailsActionFailure(this.failure, super.invoice);
  final Failure failure;
}
