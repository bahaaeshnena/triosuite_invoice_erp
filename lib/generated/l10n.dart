// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TrioSuite`
  String get appName {
    return Intl.message('TrioSuite', name: 'appName', desc: '', args: []);
  }

  /// `Your business, all in one place`
  String get loginTagline {
    return Intl.message(
      'Your business, all in one place',
      name: 'loginTagline',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue to your account`
  String get loginSubtitle {
    return Intl.message(
      'Sign in to continue to your account',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `name@company.com`
  String get emailHint {
    return Intl.message(
      'name@company.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Show password`
  String get showPassword {
    return Intl.message(
      'Show password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hide password`
  String get hidePassword {
    return Intl.message(
      'Hide password',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Need help? Contact support`
  String get supportHint {
    return Intl.message(
      'Need help? Contact support',
      name: 'supportHint',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Enter your username`
  String get usernameHint {
    return Intl.message(
      'Enter your username',
      name: 'usernameHint',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get isRequired {
    return Intl.message(
      'This field is required',
      name: 'isRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Invoices`
  String get invoices {
    return Intl.message('Invoices', name: 'invoices', desc: '', args: []);
  }

  /// `Customers`
  String get customers {
    return Intl.message('Customers', name: 'customers', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Reports`
  String get reports {
    return Intl.message('Reports', name: 'reports', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Main menu`
  String get mainMenu {
    return Intl.message('Main menu', name: 'mainMenu', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Trio Technology Co.`
  String get companyName {
    return Intl.message(
      'Trio Technology Co.',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Administrator`
  String get adminAccount {
    return Intl.message(
      'Administrator',
      name: 'adminAccount',
      desc: '',
      args: [],
    );
  }

  /// `Good morning, Ahmad`
  String get dashboardGreeting {
    return Intl.message(
      'Good morning, Ahmad',
      name: 'dashboardGreeting',
      desc: '',
      args: [],
    );
  }

  /// `Here is your business summary for today`
  String get dashboardSubtitle {
    return Intl.message(
      'Here is your business summary for today',
      name: 'dashboardSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Business overview`
  String get businessOverview {
    return Intl.message(
      'Business overview',
      name: 'businessOverview',
      desc: '',
      args: [],
    );
  }

  /// `Total sales`
  String get totalSales {
    return Intl.message('Total sales', name: 'totalSales', desc: '', args: []);
  }

  /// `Outstanding`
  String get outstanding {
    return Intl.message('Outstanding', name: 'outstanding', desc: '', args: []);
  }

  /// `Paid invoices`
  String get paidInvoices {
    return Intl.message(
      'Paid invoices',
      name: 'paidInvoices',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get thisMonth {
    return Intl.message('This month', name: 'thisMonth', desc: '', args: []);
  }

  /// `Quick actions`
  String get quickActions {
    return Intl.message(
      'Quick actions',
      name: 'quickActions',
      desc: '',
      args: [],
    );
  }

  /// `New invoice`
  String get newInvoice {
    return Intl.message('New invoice', name: 'newInvoice', desc: '', args: []);
  }

  /// `Add customer`
  String get addCustomer {
    return Intl.message(
      'Add customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get addProduct {
    return Intl.message('Add product', name: 'addProduct', desc: '', args: []);
  }

  /// `View reports`
  String get viewReports {
    return Intl.message(
      'View reports',
      name: 'viewReports',
      desc: '',
      args: [],
    );
  }

  /// `Recent invoices`
  String get recentInvoices {
    return Intl.message(
      'Recent invoices',
      name: 'recentInvoices',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: '', args: []);
  }

  /// `Invoice number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message('Customer', name: 'customer', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Overdue`
  String get overdue {
    return Intl.message('Overdue', name: 'overdue', desc: '', args: []);
  }

  /// `Create invoice`
  String get createInvoice {
    return Intl.message(
      'Create invoice',
      name: 'createInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Enter the customer and item details to issue a new invoice`
  String get createInvoiceSubtitle {
    return Intl.message(
      'Enter the customer and item details to issue a new invoice',
      name: 'createInvoiceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Customer details`
  String get customerDetails {
    return Intl.message(
      'Customer details',
      name: 'customerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select a customer`
  String get selectCustomer {
    return Intl.message(
      'Select a customer',
      name: 'selectCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Customer name`
  String get customerName {
    return Intl.message(
      'Customer name',
      name: 'customerName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Al Ofoq Company`
  String get customerNameHint {
    return Intl.message(
      'e.g. Al Ofoq Company',
      name: 'customerNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `+962 7X XXX XXXX`
  String get phoneHint {
    return Intl.message(
      '+962 7X XXX XXXX',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Invoice details`
  String get invoiceDetails {
    return Intl.message(
      'Invoice details',
      name: 'invoiceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Issue date`
  String get invoiceDate {
    return Intl.message('Issue date', name: 'invoiceDate', desc: '', args: []);
  }

  /// `Due date`
  String get dueDate {
    return Intl.message('Due date', name: 'dueDate', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Tax number`
  String get taxNumber {
    return Intl.message('Tax number', name: 'taxNumber', desc: '', args: []);
  }

  /// `Invoice items`
  String get invoiceItems {
    return Intl.message(
      'Invoice items',
      name: 'invoiceItems',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message('Item', name: 'item', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Tax`
  String get tax {
    return Intl.message('Tax', name: 'tax', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Add item`
  String get addItem {
    return Intl.message('Add item', name: 'addItem', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Tax amount`
  String get taxAmount {
    return Intl.message('Tax amount', name: 'taxAmount', desc: '', args: []);
  }

  /// `Grand total`
  String get grandTotal {
    return Intl.message('Grand total', name: 'grandTotal', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Add a note to display on the invoice (optional)`
  String get notesHint {
    return Intl.message(
      'Add a note to display on the invoice (optional)',
      name: 'notesHint',
      desc: '',
      args: [],
    );
  }

  /// `Save as draft`
  String get saveDraft {
    return Intl.message('Save as draft', name: 'saveDraft', desc: '', args: []);
  }

  /// `Issue invoice`
  String get issueInvoice {
    return Intl.message(
      'Issue invoice',
      name: 'issueInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice details`
  String get invoiceDetailsTitle {
    return Intl.message(
      'Invoice details',
      name: 'invoiceDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Issued on`
  String get issuedOn {
    return Intl.message('Issued on', name: 'issuedOn', desc: '', args: []);
  }

  /// `Due on`
  String get dueOn {
    return Intl.message('Due on', name: 'dueOn', desc: '', args: []);
  }

  /// `Bill to`
  String get billTo {
    return Intl.message('Bill to', name: 'billTo', desc: '', args: []);
  }

  /// `Payment summary`
  String get paymentSummary {
    return Intl.message(
      'Payment summary',
      name: 'paymentSummary',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Bank transfer`
  String get bankTransfer {
    return Intl.message(
      'Bank transfer',
      name: 'bankTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Download PDF`
  String get downloadPdf {
    return Intl.message(
      'Download PDF',
      name: 'downloadPdf',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get printInvoice {
    return Intl.message('Print', name: 'printInvoice', desc: '', args: []);
  }

  /// `Send to customer`
  String get sendInvoice {
    return Intl.message(
      'Send to customer',
      name: 'sendInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Invoice created`
  String get invoiceCreated {
    return Intl.message(
      'Invoice created',
      name: 'invoiceCreated',
      desc: '',
      args: [],
    );
  }

  /// `Payment received`
  String get paymentReceived {
    return Intl.message(
      'Payment received',
      name: 'paymentReceived',
      desc: '',
      args: [],
    );
  }

  /// `Laptop computer`
  String get itemLaptop {
    return Intl.message(
      'Laptop computer',
      name: 'itemLaptop',
      desc: '',
      args: [],
    );
  }

  /// `Technical support service`
  String get itemSupport {
    return Intl.message(
      'Technical support service',
      name: 'itemSupport',
      desc: '',
      args: [],
    );
  }

  /// `Draft`
  String get draft {
    return Intl.message('Draft', name: 'draft', desc: '', args: []);
  }

  /// `Sales`
  String get sales {
    return Intl.message('Sales', name: 'sales', desc: '', args: []);
  }

  /// `Expenses`
  String get expenses {
    return Intl.message('Expenses', name: 'expenses', desc: '', args: []);
  }

  /// `SAR`
  String get sar {
    return Intl.message('SAR', name: 'sar', desc: '', args: []);
  }

  /// `Digital Horizon Co.`
  String get sampleCustomerDigitalHorizon {
    return Intl.message(
      'Digital Horizon Co.',
      name: 'sampleCustomerDigitalHorizon',
      desc: '',
      args: [],
    );
  }

  /// `Modern Construction Est.`
  String get sampleCustomerModernConstruction {
    return Intl.message(
      'Modern Construction Est.',
      name: 'sampleCustomerModernConstruction',
      desc: '',
      args: [],
    );
  }

  /// `Point of Sale Store`
  String get sampleCustomerPointOfSale {
    return Intl.message(
      'Point of Sale Store',
      name: 'sampleCustomerPointOfSale',
      desc: '',
      args: [],
    );
  }

  /// `The requested page was not found`
  String get noRouteDefined {
    return Intl.message(
      'The requested page was not found',
      name: 'noRouteDefined',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
