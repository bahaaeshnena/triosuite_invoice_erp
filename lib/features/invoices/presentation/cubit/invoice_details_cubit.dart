import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';

part 'invoice_details_state.dart';

class InvoiceDetailsCubit extends Cubit<InvoiceDetailsState> {
  InvoiceDetailsCubit({required this.invoiceRepo})
    : super(InvoiceDetailsInitial());

  final InvoiceRepo invoiceRepo;

  Future<void> load(int id) async {
    emit(InvoiceDetailsLoading());
    final result = await invoiceRepo.getInvoice(id);
    result.fold(
      (failure) => emit(InvoiceDetailsLoadFailure(failure)),
      (invoice) => emit(InvoiceDetailsSuccess(invoice)),
    );
  }

  Future<void> approve() async {
    final current = state;
    if (current is! InvoiceDetailsSuccess) return;
    emit(InvoiceDetailsActionLoading(current.invoice));
    final result = await invoiceRepo.approveInvoice(current.invoice.id);
    result.fold(
      (failure) => emit(InvoiceDetailsActionFailure(failure, current.invoice)),
      (_) => load(current.invoice.id),
    );
  }

  Future<void> cancel({required String reasonAr, String? reasonEn}) async {
    final current = state;
    if (current is! InvoiceDetailsSuccess) return;
    emit(InvoiceDetailsActionLoading(current.invoice));
    final result = await invoiceRepo.cancelInvoice(
      id: current.invoice.id,
      reasonAr: reasonAr,
      reasonEn: reasonEn,
    );
    result.fold(
      (failure) => emit(InvoiceDetailsActionFailure(failure, current.invoice)),
      (_) => load(current.invoice.id),
    );
  }
}
