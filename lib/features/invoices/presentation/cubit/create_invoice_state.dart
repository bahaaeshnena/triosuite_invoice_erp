part of 'create_invoice_cubit.dart';

@immutable
sealed class CreateInvoiceState {}

final class CreateInvoiceInitial extends CreateInvoiceState {}

final class CreateInvoiceLoading extends CreateInvoiceState {}

final class CreateInvoiceReady extends CreateInvoiceState {
  CreateInvoiceReady(this.lookups);
  final InvoiceLookupsEntity lookups;
}

final class CreateInvoiceSaving extends CreateInvoiceReady {
  CreateInvoiceSaving(super.lookups);
}

final class CreateInvoiceSuccess extends CreateInvoiceState {
  CreateInvoiceSuccess(this.invoice);
  final SavedInvoiceEntity invoice;
}

final class CreateInvoiceLoadFailure extends CreateInvoiceState {
  CreateInvoiceLoadFailure(this.failure);
  final Failure failure;
}

final class CreateInvoiceFailure extends CreateInvoiceReady {
  CreateInvoiceFailure(this.failure, super.lookups);
  final Failure failure;
}
