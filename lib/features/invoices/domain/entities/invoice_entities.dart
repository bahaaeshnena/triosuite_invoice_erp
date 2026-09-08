class InvoiceSummaryEntity {
  const InvoiceSummaryEntity({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.customerId,
    required this.customerNameAr,
    required this.customerNameEn,
    required this.currencyCode,
    required this.taxMode,
    required this.status,
    required this.totalAmount,
  });

  final int id;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final int customerId;
  final String customerNameAr;
  final String customerNameEn;
  final String currencyCode;
  final String taxMode;
  final String status;
  final double totalAmount;
}

class InvoiceItemEntity {
  const InvoiceItemEntity({
    required this.id,
    required this.itemId,
    required this.itemCode,
    required this.itemNameAr,
    required this.itemNameEn,
    required this.unitId,
    required this.unitCode,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
    required this.taxAmount,
    required this.lineSubTotal,
    required this.lineTotal,
    this.barcode,
  });

  final int id;
  final int itemId;
  final String itemCode;
  final String itemNameAr;
  final String itemNameEn;
  final String? barcode;
  final int unitId;
  final String unitCode;
  final double quantity;
  final double unitPrice;
  final double taxRate;
  final double taxAmount;
  final double lineSubTotal;
  final double lineTotal;
}

class InvoiceDetailsEntity {
  const InvoiceDetailsEntity({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.customerId,
    required this.customerNameAr,
    required this.customerNameEn,
    required this.currencyId,
    required this.currencyCode,
    required this.exchangeRate,
    required this.taxMode,
    required this.status,
    required this.subTotal,
    required this.taxAmount,
    required this.totalAmount,
    required this.baseCurrencyTotal,
    required this.createdAt,
    required this.items,
    this.notesAr,
    this.notesEn,
    this.approvedAt,
    this.cancelledAt,
    this.cancellationReasonAr,
    this.cancellationReasonEn,
  });

  final int id;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final int customerId;
  final String customerNameAr;
  final String customerNameEn;
  final int currencyId;
  final String currencyCode;
  final double exchangeRate;
  final String taxMode;
  final String status;
  final double subTotal;
  final double taxAmount;
  final double totalAmount;
  final double baseCurrencyTotal;
  final String? notesAr;
  final String? notesEn;
  final DateTime createdAt;
  final DateTime? approvedAt;
  final DateTime? cancelledAt;
  final String? cancellationReasonAr;
  final String? cancellationReasonEn;
  final List<InvoiceItemEntity> items;
}

class CustomerEntity {
  const CustomerEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  final int id;
  final String code;
  final String nameAr;
  final String nameEn;
}

class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.unitId,
    required this.unitCode,
    required this.unitPrice,
    required this.taxRate,
    this.barcode,
  });

  final int id;
  final String code;
  final String nameAr;
  final String nameEn;
  final String? barcode;
  final int unitId;
  final String unitCode;
  final double unitPrice;
  final double taxRate;
}

class CurrencyEntity {
  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.isBaseCurrency,
    this.symbol,
  });

  final int id;
  final String code;
  final String nameAr;
  final String nameEn;
  final String? symbol;
  final bool isBaseCurrency;
}

class TaxModeEntity {
  const TaxModeEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  final int id;
  final String code;
  final String nameAr;
  final String nameEn;
}

class InvoiceLookupsEntity {
  const InvoiceLookupsEntity({
    required this.customers,
    required this.items,
    required this.currencies,
    required this.taxModes,
    this.defaultCurrencyId,
  });

  final List<CustomerEntity> customers;
  final List<ItemEntity> items;
  final List<CurrencyEntity> currencies;
  final List<TaxModeEntity> taxModes;
  final int? defaultCurrencyId;
}

class SaveInvoiceItemEntity {
  const SaveInvoiceItemEntity({
    required this.itemId,
    required this.unitId,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });

  final int itemId;
  final int unitId;
  final double quantity;
  final double unitPrice;
  final double taxRate;

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'unitId': unitId,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'taxRate': taxRate,
  };
}

class SaveInvoiceEntity {
  const SaveInvoiceEntity({
    required this.invoiceDate,
    required this.customerId,
    required this.currencyId,
    required this.exchangeRate,
    required this.taxMode,
    required this.items,
    this.notesAr,
    this.notesEn,
  });

  final DateTime invoiceDate;
  final int customerId;
  final int currencyId;
  final double exchangeRate;
  final String taxMode;
  final String? notesAr;
  final String? notesEn;
  final List<SaveInvoiceItemEntity> items;

  Map<String, dynamic> toJson() => {
    'invoiceDate': invoiceDate.toIso8601String(),
    'customerId': customerId,
    'currencyId': currencyId,
    'exchangeRate': exchangeRate,
    'taxMode': taxMode,
    'notesAr': notesAr,
    'notesEn': notesEn,
    'items': items.map((item) => item.toJson()).toList(),
  };
}

class SavedInvoiceEntity {
  const SavedInvoiceEntity({required this.id, required this.invoiceNumber});

  final int id;
  final String invoiceNumber;
}
