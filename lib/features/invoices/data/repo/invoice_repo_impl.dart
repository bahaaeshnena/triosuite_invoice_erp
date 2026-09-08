import 'package:dartz/dartz.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/invoices/data/models/invoice_models.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/repo/invoice_repo.dart';

class InvoiceRepoImpl implements InvoiceRepo {
  const InvoiceRepoImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<Failure, List<InvoiceSummaryEntity>>> getInvoices({
    String? status,
    String? search,
  }) async {
    try {
      final response = await apiClient.get(
        endPoint: EndPoints.invoices,
        queryParameters: {
          if (status != null && status.isNotEmpty) 'status': status,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      final data = response['data'] as List<dynamic>? ?? const [];
      return Right(
        data
            .map(
              (json) => InvoiceSummaryModel.fromJson(
                Map<String, dynamic>.from(json as Map),
              ).toEntity(),
            )
            .toList(),
      );
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, InvoiceDetailsEntity>> getInvoice(int id) async {
    try {
      final response = await apiClient.get(endPoint: EndPoints.invoice(id));
      return Right(InvoiceDetailsModel.fromJson(response).toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, InvoiceLookupsEntity>> getLookups() async {
    try {
      final response = await apiClient.get(endPoint: EndPoints.lookups);
      final settings = await apiClient.get(endPoint: EndPoints.settings);
      final defaultCurrency = settings['defaultCurrencyId'];
      return Right(
        InvoiceLookupsModel.fromJson(response).toEntity(
          defaultCurrencyId: defaultCurrency is int
              ? defaultCurrency
              : int.tryParse('$defaultCurrency'),
        ),
      );
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, SavedInvoiceEntity>> createInvoice(
    SaveInvoiceEntity invoice,
  ) async {
    try {
      final response = await apiClient.post(
        endPoint: EndPoints.invoices,
        data: invoice.toJson(),
      );
      return Right(
        SavedInvoiceEntity(
          id: _int(response['id']),
          invoiceNumber: response['invoiceNumber'] as String,
        ),
      );
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  @override
  Future<Either<Failure, Unit>> approveInvoice(int id) =>
      _postAction(EndPoints.approveInvoice(id));

  @override
  Future<Either<Failure, Unit>> cancelInvoice({
    required int id,
    required String reasonAr,
    String? reasonEn,
  }) => _postAction(
    EndPoints.cancelInvoice(id),
    data: {'reasonAr': reasonAr, 'reasonEn': reasonEn},
  );

  Future<Either<Failure, Unit>> _postAction(
    String endPoint, {
    Object? data,
  }) async {
    try {
      await apiClient.post(endPoint: endPoint, data: data);
      return const Right(unit);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (_) {
      return Left(ServerFailure('Unexpected Error, Please try again later'));
    }
  }

  int _int(Object? value) => value is int ? value : int.parse('$value');
}
