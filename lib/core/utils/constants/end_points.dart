abstract final class EndPoints {
  static const login = 'auth/login';
  static const refresh = 'auth/refresh';
  static const logout = 'auth/logout';
  static const invoices = 'invoices';
  static const lookups = 'lookups';
  static const settings = 'settings';

  static String invoice(int id) => '$invoices/$id';
  static String approveInvoice(int id) => '${invoice(id)}/approve';
  static String cancelInvoice(int id) => '${invoice(id)}/cancel';
}
