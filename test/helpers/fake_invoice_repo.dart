import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';

class FakeInvoiceRepo implements InvoiceRepo {
  final lookups = const InvoiceLookupsEntity(
    defaultCurrencyId: 1,
    customers: [
      CustomerEntity(
        id: 1,
        code: 'C001',
        nameAr: 'شركة الأفق',
        nameEn: 'Horizon Co.',
      ),
    ],
    items: [
      ItemEntity(
        id: 1,
        code: 'I001',
        nameAr: 'حاسوب',
        nameEn: 'Laptop',
        unitId: 1,
        unitCode: 'PCS',
        unitPrice: 100,
        taxRate: 15,
        barcode: '123456',
      ),
    ],
    currencies: [
      CurrencyEntity(
        id: 1,
        code: 'JOD',
        nameAr: 'دينار أردني',
        nameEn: 'Jordanian Dinar',
        isBaseCurrency: true,
      ),
    ],
    taxModes: [
      TaxModeEntity(
        id: 1,
        code: 'EXCLUSIVE',
        nameAr: 'غير شاملة',
        nameEn: 'Exclusive',
      ),
    ],
  );

  @override
  Future<Either<Failure, List<InvoiceSummaryEntity>>> getInvoices({
    String? status,
    String? search,
  }) async => const Right([]);

  @override
  Future<Either<Failure, InvoiceLookupsEntity>> getLookups() async =>
      Right(lookups);

  @override
  Future<Either<Failure, InvoiceDetailsEntity>> getInvoice(int id) async =>
      Right(
        InvoiceDetailsEntity(
          id: id,
          invoiceNumber: 'INV-2026-000001',
          invoiceDate: DateTime(2026, 9, 8),
          customerId: 1,
          customerNameAr: 'شركة الأفق',
          customerNameEn: 'Horizon Co.',
          currencyId: 1,
          currencyCode: 'JOD',
          exchangeRate: 1,
          taxMode: 'EXCLUSIVE',
          status: 'DRAFT',
          subTotal: 100,
          taxAmount: 15,
          totalAmount: 115,
          baseCurrencyTotal: 115,
          createdAt: DateTime(2026, 9, 8),
          items: const [
            InvoiceItemEntity(
              id: 1,
              itemId: 1,
              itemCode: 'I001',
              itemNameAr: 'حاسوب',
              itemNameEn: 'Laptop',
              unitId: 1,
              unitCode: 'PCS',
              quantity: 1,
              unitPrice: 100,
              taxRate: 15,
              taxAmount: 15,
              lineSubTotal: 100,
              lineTotal: 115,
            ),
          ],
        ),
      );

  @override
  Future<Either<Failure, SavedInvoiceEntity>> createInvoice(
    SaveInvoiceEntity invoice,
  ) async =>
      const Right(SavedInvoiceEntity(id: 1, invoiceNumber: 'INV-2026-000001'));

  @override
  Future<Either<Failure, Unit>> approveInvoice(int id) async =>
      const Right(unit);

  @override
  Future<Either<Failure, Unit>> cancelInvoice({
    required int id,
    required String reasonAr,
    String? reasonEn,
  }) async => const Right(unit);
}
