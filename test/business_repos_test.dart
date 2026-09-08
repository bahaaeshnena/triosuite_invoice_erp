import 'package:flutter_test/flutter_test.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/invoices/data/repo/invoice_repo_impl.dart';
import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';
import 'package:triosuite_invoice_erp/features/settings/data/repo/settings_repo_impl.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';

void main() {
  test('invoice list maps API data to domain entities', () async {
    final client = _RecordingApiClient(
      onGet: (endPoint, query) async {
        expect(endPoint, EndPoints.invoices);
        expect(query, {'status': 'DRAFT', 'search': 'INV'});
        return {
          'data': [
            {
              'id': 4,
              'invoiceNumber': 'INV-2026-000004',
              'invoiceDate': '2026-09-08T00:00:00',
              'customerId': 2,
              'customerNameAr': 'عميل',
              'customerNameEn': 'Customer',
              'currencyCode': 'JOD',
              'taxMode': 'EXCLUSIVE',
              'status': 'DRAFT',
              'totalAmount': 23.0,
            },
          ],
        };
      },
    );
    final repo = InvoiceRepoImpl(apiClient: client);

    final result = await repo.getInvoices(status: 'DRAFT', search: 'INV');

    result.fold((failure) => fail(failure.message), (invoices) {
      expect(invoices.single.id, 4);
      expect(invoices.single.totalAmount, 23);
      expect(invoices.single.status, 'DRAFT');
    });
  });

  test(
    'create invoice sends the API contract and returns generated number',
    () async {
      Object? payload;
      final client = _RecordingApiClient(
        onPost: (endPoint, data) async {
          expect(endPoint, EndPoints.invoices);
          payload = data;
          return {'id': 9, 'invoiceNumber': 'INV-2026-000009'};
        },
      );
      final repo = InvoiceRepoImpl(apiClient: client);
      final request = SaveInvoiceEntity(
        invoiceDate: DateTime.utc(2026, 9, 8),
        customerId: 1,
        currencyId: 2,
        exchangeRate: 0.71,
        taxMode: 'INCLUSIVE',
        notesEn: 'Demo',
        items: const [
          SaveInvoiceItemEntity(
            itemId: 3,
            unitId: 1,
            quantity: 2,
            unitPrice: 10,
            taxRate: 15,
          ),
        ],
      );

      final result = await repo.createInvoice(request);

      result.fold((failure) => fail(failure.message), (invoice) {
        expect(invoice.id, 9);
        expect(invoice.invoiceNumber, 'INV-2026-000009');
      });
      final json = payload! as Map<String, dynamic>;
      expect(json['taxMode'], 'INCLUSIVE');
      expect(json['exchangeRate'], 0.71);
      expect((json['items'] as List).single['itemId'], 3);
    },
  );

  test('company settings update uses PUT and maps the saved values', () async {
    final client = _RecordingApiClient(
      onPut: (endPoint, data) async {
        expect(endPoint, EndPoints.settings);
        expect((data! as Map<String, dynamic>)['invoicePrefix'], 'SALE');
        return {
          'id': 1,
          'companyNameAr': 'تريو',
          'companyNameEn': 'Trio',
          'defaultCurrencyId': 1,
          'defaultCurrencyCode': 'JOD',
          'invoicePrefix': 'SALE',
        };
      },
    );
    final repo = SettingsRepoImpl(apiClient: client);

    final result = await repo.updateSettings(
      const CompanySettingsFormEntity(
        companyNameAr: 'تريو',
        companyNameEn: 'Trio',
        defaultCurrencyId: 1,
        invoicePrefix: 'SALE',
      ),
    );

    result.fold(
      (failure) => fail(failure.message),
      (settings) => expect(settings.invoicePrefix, 'SALE'),
    );
  });
}

class _RecordingApiClient implements ApiClient {
  _RecordingApiClient({this.onGet, this.onPost, this.onPut});

  final Future<Map<String, dynamic>> Function(
    String endPoint,
    Map<String, dynamic>? query,
  )?
  onGet;
  final Future<Map<String, dynamic>> Function(String endPoint, Object? data)?
  onPost;
  final Future<Map<String, dynamic>> Function(String endPoint, Object? data)?
  onPut;

  @override
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) => onGet!(endPoint, queryParameters);

  @override
  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => onPost!(endPoint, data);

  @override
  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => onPut!(endPoint, data);

  @override
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => throw UnimplementedError();
}
