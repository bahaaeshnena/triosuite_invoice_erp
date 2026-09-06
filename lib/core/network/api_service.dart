import 'package:dio/dio.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';

class ApiService extends ApiClient {
  ApiService(this._dio, {String baseUrl = defaultBaseUrl}) {
    _dio.options
      ..baseUrl = _withTrailingSlash(baseUrl)
      ..connectTimeout = const Duration(seconds: 15)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..contentType = Headers.jsonContentType
      ..responseType = ResponseType.json
      ..headers = const {Headers.acceptHeader: Headers.jsonContentType};
  }

  static const String defaultBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5112/api/',
  );

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) => _request(
    method: 'GET',
    endPoint: endPoint,
    queryParameters: queryParameters,
  );

  @override
  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => _request(
    method: 'POST',
    endPoint: endPoint,
    queryParameters: query,
    data: data,
  );

  @override
  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => _request(
    method: 'PUT',
    endPoint: endPoint,
    queryParameters: query,
    data: data,
  );

  @override
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => _request(
    method: 'DELETE',
    endPoint: endPoint,
    queryParameters: query,
    data: data,
  );

  @override
  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => _request(
    method: 'PATCH',
    endPoint: endPoint,
    queryParameters: query,
    data: data,
  );

  Future<Map<String, dynamic>> _request({
    required String method,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      final response = await _dio.request<Object?>(
        _normalizeEndPoint(endPoint),
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      final responseData = response.data;
      if (responseData == null) return <String, dynamic>{};
      if (responseData is Map) return Map<String, dynamic>.from(responseData);

      // The current client contract returns a map. Array responses are kept
      // under `data` so endpoints such as GET /invoices are still supported.
      return <String, dynamic>{'data': responseData};
    } on DioException catch (exception) {
      throw ServerFailure.fromDioException(exception);
    }
  }

  static String _normalizeEndPoint(String value) =>
      value.trim().replaceFirst(RegExp(r'^/+'), '');

  static String _withTrailingSlash(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(value, 'baseUrl', 'Base URL cannot be empty.');
    }
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }
}
