import 'package:triosuite_invoice_erp/features/invoices/domain/entities/invoice_entities.dart';

int _int(Object? value) => value is int ? value : int.parse('$value');
double _double(Object? value) =>
    value is num ? value.toDouble() : double.parse('$value');
DateTime? _dateOrNull(Object? value) =>
    value == null ? null : DateTime.parse('$value');

class InvoiceSummaryModel {
  const InvoiceSummaryModel(this.json);
  final Map<String, dynamic> json;

  factory InvoiceSummaryModel.fromJson(Map<String, dynamic> json) =>
      InvoiceSummaryModel(json);

  InvoiceSummaryEntity toEntity() => InvoiceSummaryEntity(
    id: _int(json['id']),
    invoiceNumber: json['invoiceNumber'] as String,
    invoiceDate: DateTime.parse(json['invoiceDate'] as String),
    customerId: _int(json['customerId']),
    customerNameAr: json['customerNameAr'] as String,
    customerNameEn: json['customerNameEn'] as String,
    currencyCode: json['currencyCode'] as String,
    taxMode: json['taxMode'] as String,
    status: json['status'] as String,
    totalAmount: _double(json['totalAmount']),
  );
}

class InvoiceDetailsModel {
  const InvoiceDetailsModel(this.json);
  final Map<String, dynamic> json;

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsModel(json);

  InvoiceDetailsEntity toEntity() => InvoiceDetailsEntity(
    id: _int(json['id']),
    invoiceNumber: json['invoiceNumber'] as String,
    invoiceDate: DateTime.parse(json['invoiceDate'] as String),
    customerId: _int(json['customerId']),
    customerNameAr: json['customerNameAr'] as String,
    customerNameEn: json['customerNameEn'] as String,
    currencyId: _int(json['currencyId']),
    currencyCode: json['currencyCode'] as String,
    exchangeRate: _double(json['exchangeRate']),
    taxMode: json['taxMode'] as String,
    status: json['status'] as String,
    subTotal: _double(json['subTotal']),
    taxAmount: _double(json['taxAmount']),
    totalAmount: _double(json['totalAmount']),
    baseCurrencyTotal: _double(json['baseCurrencyTotal']),
    notesAr: json['notesAr'] as String?,
    notesEn: json['notesEn'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    approvedAt: _dateOrNull(json['approvedAt']),
    cancelledAt: _dateOrNull(json['cancelledAt']),
    cancellationReasonAr: json['cancellationReasonAr'] as String?,
    cancellationReasonEn: json['cancellationReasonEn'] as String?,
    items: (json['items'] as List<dynamic>? ?? const [])
        .map((item) => _invoiceItem(Map<String, dynamic>.from(item as Map)))
        .toList(),
  );

  static InvoiceItemEntity _invoiceItem(Map<String, dynamic> json) =>
      InvoiceItemEntity(
        id: _int(json['id']),
        itemId: _int(json['itemId']),
        itemCode: json['itemCode'] as String,
        itemNameAr: json['itemNameAr'] as String,
        itemNameEn: json['itemNameEn'] as String,
        barcode: json['barcode'] as String?,
        unitId: _int(json['unitId']),
        unitCode: json['unitCode'] as String,
        quantity: _double(json['quantity']),
        unitPrice: _double(json['unitPrice']),
        taxRate: _double(json['taxRate']),
        taxAmount: _double(json['taxAmount']),
        lineSubTotal: _double(json['lineSubTotal']),
        lineTotal: _double(json['lineTotal']),
      );
}

class InvoiceLookupsModel {
  const InvoiceLookupsModel(this.json);
  final Map<String, dynamic> json;

  factory InvoiceLookupsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceLookupsModel(json);

  InvoiceLookupsEntity toEntity({int? defaultCurrencyId}) =>
      InvoiceLookupsEntity(
        customers: _list('customers')
            .map(
              (item) => CustomerEntity(
                id: _int(item['id']),
                code: item['code'] as String,
                nameAr: item['nameAr'] as String,
                nameEn: item['nameEn'] as String,
              ),
            )
            .toList(),
        items: _list('items')
            .map(
              (item) => ItemEntity(
                id: _int(item['id']),
                code: item['code'] as String,
                nameAr: item['nameAr'] as String,
                nameEn: item['nameEn'] as String,
                barcode: item['barcode'] as String?,
                unitId: _int(item['unitId']),
                unitCode: item['unitCode'] as String,
                unitPrice: _double(item['unitPrice']),
                taxRate: _double(item['taxRate']),
              ),
            )
            .toList(),
        currencies: _list('currencies')
            .map(
              (item) => CurrencyEntity(
                id: _int(item['id']),
                code: item['code'] as String,
                nameAr: item['nameAr'] as String,
                nameEn: item['nameEn'] as String,
                symbol: item['symbol'] as String?,
                isBaseCurrency: item['isBaseCurrency'] as bool,
              ),
            )
            .toList(),
        taxModes: _list('taxModes')
            .map(
              (item) => TaxModeEntity(
                id: _int(item['id']),
                code: item['code'] as String,
                nameAr: item['nameAr'] as String,
                nameEn: item['nameEn'] as String,
              ),
            )
            .toList(),
        defaultCurrencyId: defaultCurrencyId,
      );

  List<Map<String, dynamic>> _list(String key) =>
      (json[key] as List<dynamic>? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
}
