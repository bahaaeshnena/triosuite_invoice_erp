import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';

part 'invoice_list_state.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  InvoiceListCubit({required this.invoiceRepo}) : super(InvoiceListInitial());

  final InvoiceRepo invoiceRepo;

  Future<void> load({String? status, String? search}) async {
    emit(InvoiceListLoading());
    final result = await invoiceRepo.getInvoices(
      status: status,
      search: search,
    );
    result.fold(
      (failure) => emit(InvoiceListFailure(failure)),
      (invoices) => emit(InvoiceListSuccess(invoices)),
    );
  }
}
