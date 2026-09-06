abstract class ApiClient {
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  });

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  });

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  });

  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  });
}
