import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';

part 'create_invoice_state.dart';

class CreateInvoiceCubit extends Cubit<CreateInvoiceState> {
  CreateInvoiceCubit({required this.invoiceRepo})
    : super(CreateInvoiceInitial());

  final InvoiceRepo invoiceRepo;

  Future<void> loadLookups() async {
    emit(CreateInvoiceLoading());
    final result = await invoiceRepo.getLookups();
    result.fold(
      (failure) => emit(CreateInvoiceLoadFailure(failure)),
      (lookups) => emit(CreateInvoiceReady(lookups)),
    );
  }

  Future<void> save(SaveInvoiceEntity invoice, {required bool approve}) async {
    final current = state;
    if (current is! CreateInvoiceReady) return;
    emit(CreateInvoiceSaving(current.lookups));
    final created = await invoiceRepo.createInvoice(invoice);
    await created.fold(
      (failure) async => emit(CreateInvoiceFailure(failure, current.lookups)),
      (saved) async {
        if (!approve) {
          emit(CreateInvoiceSuccess(saved));
          return;
        }
        final approved = await invoiceRepo.approveInvoice(saved.id);
        approved.fold(
          (_) => emit(CreateInvoiceSuccess(saved)),
          (_) => emit(CreateInvoiceSuccess(saved)),
        );
      },
    );
  }
}
