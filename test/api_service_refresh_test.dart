import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triosuite_invoice_erp/core/network/api_service.dart';
import 'package:triosuite_invoice_erp/core/services/secure_storage_service.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorageService secureStorage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    await Prefs.init();
    secureStorage = const SecureStorageService(FlutterSecureStorage());
  });

  test('refreshes an expiring token once for concurrent requests', () async {
    await _storeSession(
      secureStorage,
      accessToken: 'old-access-token',
      refreshToken: 'old-refresh-token',
      accessExpiresAt: DateTime.now().toUtc().subtract(
        const Duration(seconds: 1),
      ),
    );
    var refreshCalls = 0;
    final requestTokens = <String?>[];
    final adapter = _FakeAdapter((options) async {
      if (options.uri.path.endsWith('/auth/refresh')) {
        refreshCalls++;
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return _jsonResponse(_sessionJson(), 200);
      }
      requestTokens.add(options.headers['Authorization'] as String?);
      return _jsonResponse(<String, dynamic>{'ok': true}, 200);
    });
    final dio = Dio()..httpClientAdapter = adapter;
    final api = ApiService(
      dio,
      secureStorage,
      baseUrl: 'https://example.test/api/',
    );

    await Future.wait([
      api.get(endPoint: 'invoices'),
      api.get(endPoint: 'settings'),
    ]);

    expect(refreshCalls, 1);
    expect(requestTokens, everyElement('Bearer new-access-token'));
    expect(await secureStorage.read(kAccessToken), 'new-access-token');
    expect(await secureStorage.read(kRefreshToken), 'new-refresh-token');
  });

  test('refreshes and retries once after an unexpected 401 response', () async {
    await _storeSession(
      secureStorage,
      accessToken: 'old-access-token',
      refreshToken: 'old-refresh-token',
      accessExpiresAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
    );
    var invoiceCalls = 0;
    var refreshCalls = 0;
    final requestTokens = <String?>[];
    final adapter = _FakeAdapter((options) async {
      if (options.uri.path.endsWith('/auth/refresh')) {
        refreshCalls++;
        return _jsonResponse(_sessionJson(), 200);
      }
      invoiceCalls++;
      requestTokens.add(options.headers['Authorization'] as String?);
      if (invoiceCalls == 1) {
        return _jsonResponse({'message': 'Unauthorized'}, 401);
      }
      return _jsonResponse(<String, dynamic>{'ok': true}, 200);
    });
    final dio = Dio()..httpClientAdapter = adapter;
    final api = ApiService(
      dio,
      secureStorage,
      baseUrl: 'https://example.test/api/',
    );

    final response = await api.get(endPoint: 'invoices/1');

    expect(response['ok'], isTrue);
    expect(refreshCalls, 1);
    expect(invoiceCalls, 2);
    expect(requestTokens, [
      'Bearer old-access-token',
      'Bearer new-access-token',
    ]);
  });
}

Future<void> _storeSession(
  SecureStorageService secureStorage, {
  required String accessToken,
  required String refreshToken,
  required DateTime accessExpiresAt,
}) async {
  await secureStorage.write(key: kAccessToken, value: accessToken);
  await secureStorage.write(key: kRefreshToken, value: refreshToken);
  await Prefs.setString(
    kUserData,
    jsonEncode({
      'expiresAt': accessExpiresAt.toIso8601String(),
      'refreshTokenExpiresAt': DateTime.now()
          .toUtc()
          .add(const Duration(days: 30))
          .toIso8601String(),
      'id': 7,
      'username': 'admin',
      'fullNameAr': 'مدير النظام',
      'fullNameEn': 'Administrator',
    }),
  );
}

Map<String, dynamic> _sessionJson() {
  final now = DateTime.now().toUtc();
  return {
    'token': 'new-access-token',
    'refreshToken': 'new-refresh-token',
    'expiresAt': now.add(const Duration(minutes: 15)).toIso8601String(),
    'refreshTokenExpiresAt': now
        .add(const Duration(days: 30))
        .toIso8601String(),
    'id': 7,
    'username': 'admin',
    'fullNameAr': 'مدير النظام',
    'fullNameEn': 'Administrator',
  };
}

ResponseBody _jsonResponse(Object data, int statusCode) =>
    ResponseBody.fromString(
      jsonEncode(data),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => handler(options);

  @override
  void close({bool force = false}) {}
}
