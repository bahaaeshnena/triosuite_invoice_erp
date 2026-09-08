import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/services/secure_storage_service.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';

class ApiService extends ApiClient {
  ApiService(
    this._dio,
    this._secureStorage, {
    String baseUrl = defaultBaseUrl,
  }) {
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
    defaultValue: 'http://192.168.1.100:5112/api/',
  );

  final Dio _dio;
  final SecureStorageService _secureStorage;
  Future<bool>? _refreshInProgress;

  static const _refreshBeforeExpiry = Duration(seconds: 30);

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
    final normalizedEndPoint = _normalizeEndPoint(endPoint);
    final requiresAuthentication = !_isAuthEndPoint(normalizedEndPoint);

    if (requiresAuthentication) {
      await _refreshIfAccessTokenExpiresSoon();
    }

    try {
      final response = await _send(
        method: method,
        endPoint: normalizedEndPoint,
        queryParameters: queryParameters,
        data: data,
      );
      return _responseMap(response.data);
    } on DioException catch (exception) {
      if (requiresAuthentication && exception.response?.statusCode == 401) {
        final refreshed = await _refreshAccessToken();
        if (refreshed) {
          try {
            final response = await _send(
              method: method,
              endPoint: normalizedEndPoint,
              queryParameters: queryParameters,
              data: data,
            );
            return _responseMap(response.data);
          } on DioException catch (retryException) {
            throw ServerFailure.fromDioException(retryException);
          }
        }
      }
      throw ServerFailure.fromDioException(exception);
    }
  }

  Future<Response<Object?>> _send({
    required String method,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    final accessToken = await _secureStorage.read(kAccessToken);
    return _dio.request<Object?>(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method,
        headers: accessToken == null || accessToken.isEmpty
            ? null
            : <String, Object>{'Authorization': 'Bearer $accessToken'},
      ),
    );
  }

  Future<void> _refreshIfAccessTokenExpiresSoon() async {
    final encodedUser = Prefs.getString(kUserData);
    if (encodedUser.isEmpty) return;

    try {
      final user = Map<String, dynamic>.from(jsonDecode(encodedUser) as Map);
      final accessExpiry = DateTime.parse(user['expiresAt'] as String).toUtc();
      if (accessExpiry.isAfter(
        DateTime.now().toUtc().add(_refreshBeforeExpiry),
      )) {
        return;
      }
      await _refreshAccessToken();
    } catch (_) {
      // A malformed cache must not prevent the request. A 401 response still
      // triggers the authoritative refresh flow below.
    }
  }

  Future<bool> _refreshAccessToken() {
    final activeRefresh = _refreshInProgress;
    if (activeRefresh != null) return activeRefresh;

    final operation = _performRefresh();
    _refreshInProgress = operation;
    operation.whenComplete(() {
      if (identical(_refreshInProgress, operation)) {
        _refreshInProgress = null;
      }
    });
    return operation;
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await _secureStorage.read(kRefreshToken);
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      final response = await _dio.post<Object?>(
        EndPoints.refresh,
        data: {'refreshToken': refreshToken},
      );
      final responseData = response.data;
      if (responseData is! Map) {
        await _clearSession();
        return false;
      }
      await _saveRefreshedSession(Map<String, dynamic>.from(responseData));
      return true;
    } on DioException catch (exception) {
      if (exception.response?.statusCode == 400 ||
          exception.response?.statusCode == 401) {
        await _clearSession();
      }
      return false;
    } catch (_) {
      await _clearSession();
      return false;
    }
  }

  Future<void> _saveRefreshedSession(Map<String, dynamic> response) async {
    final accessToken = response['token'] as String?;
    final refreshToken = response['refreshToken'] as String?;
    if (accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      throw const FormatException('Invalid refresh response.');
    }

    final localUser = <String, dynamic>{
      'expiresAt': response['expiresAt'],
      'refreshTokenExpiresAt': response['refreshTokenExpiresAt'],
      'id': response['id'],
      'username': response['username'],
      'fullNameAr': response['fullNameAr'],
      'fullNameEn': response['fullNameEn'],
    };
    await _secureStorage.write(key: kAccessToken, value: accessToken);
    await _secureStorage.write(key: kRefreshToken, value: refreshToken);
    await Prefs.setString(kUserData, jsonEncode(localUser));
  }

  Future<void> _clearSession() async {
    await Future.wait([
      Prefs.remove(kUserData),
      _secureStorage.delete(kAccessToken),
      _secureStorage.delete(kRefreshToken),
    ]);
  }

  static Map<String, dynamic> _responseMap(Object? responseData) {
    if (responseData == null) return <String, dynamic>{};
    if (responseData is Map) return Map<String, dynamic>.from(responseData);

    // The current client contract returns a map. Array responses are kept
    // under `data` so endpoints such as GET /invoices are still supported.
    return <String, dynamic>{'data': responseData};
  }

  static bool _isAuthEndPoint(String endPoint) =>
      endPoint == EndPoints.login ||
      endPoint == EndPoints.refresh ||
      endPoint == EndPoints.logout;

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
