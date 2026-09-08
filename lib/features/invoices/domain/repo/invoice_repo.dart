import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';

abstract class InvoiceRepo {
  Future<Either<Failure, List<InvoiceSummaryEntity>>> getInvoices({
    String? status,
    String? search,
  });

  Future<Either<Failure, InvoiceDetailsEntity>> getInvoice(int id);

  Future<Either<Failure, InvoiceLookupsEntity>> getLookups();

  Future<Either<Failure, SavedInvoiceEntity>> createInvoice(
    SaveInvoiceEntity invoice,
  );

  Future<Either<Failure, Unit>> approveInvoice(int id);

  Future<Either<Failure, Unit>> cancelInvoice({
    required int id,
    required String reasonAr,
    String? reasonEn,
  });
}
