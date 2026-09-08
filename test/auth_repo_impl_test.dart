import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triosuite_invoice_erp/core/errors/exceptions.dart';
import 'package:triosuite_invoice_erp/core/network/api_client.dart';
import 'package:triosuite_invoice_erp/core/services/secure_storage_service.dart';
import 'package:triosuite_invoice_erp/core/services/shared_prefs.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/constants.dart';
import 'package:triosuite_invoice_erp/core/utils/constants/end_points.dart';
import 'package:triosuite_invoice_erp/features/auth/data/repo/auth_repo_impl.dart';
import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorageService secureStorage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    await Prefs.init();
    secureStorage = const SecureStorageService(FlutterSecureStorage());
  });

  test('login stores only tokens in secure storage', () async {
    final apiClient = _FakeApiClient((endPoint, data) async => _sessionJson());
    final repo = AuthRepoImpl(
      apiClient: apiClient,
      secureStorage: secureStorage,
    );

    final result = await repo.login(username: 'ahmad', password: 'secret');

    expect(result.isRight(), isTrue);
    expect(await secureStorage.read(kAccessToken), 'access-token');
    expect(await secureStorage.read(kRefreshToken), 'refresh-token');

    final cachedUser =
        jsonDecode(Prefs.getString(kUserData)) as Map<String, dynamic>;
    expect(cachedUser['username'], 'ahmad');
    expect(cachedUser.containsKey('token'), isFalse);
    expect(cachedUser.containsKey('refreshToken'), isFalse);
  });

  test('restoreSession refreshes and saves an expired access token', () async {
    final apiClient = _FakeApiClient((endPoint, data) async {
      expect(endPoint, EndPoints.refresh);
      expect(data, {'refreshToken': 'old-refresh-token'});
      return _sessionJson(
        token: 'new-access-token',
        refreshToken: 'new-refresh-token',
      );
    });
    final repo = AuthRepoImpl(
      apiClient: apiClient,
      secureStorage: secureStorage,
    );
    final now = DateTime.now().toUtc();
    await repo.saveUserToLocalStorage(
      UserEntity(
        token: 'old-access-token',
        refreshToken: 'old-refresh-token',
        expiresAt: now.subtract(const Duration(minutes: 1)),
        refreshTokenExpiresAt: now.add(const Duration(days: 1)),
        id: 7,
        username: 'ahmad',
        fullNameAr: 'أحمد الخطيب',
        fullNameEn: 'Ahmad Al-Khatib',
      ),
    );

    expect(await repo.restoreSession(), isTrue);
    expect(apiClient.postCallCount, 1);
    expect(await secureStorage.read(kAccessToken), 'new-access-token');
    expect(await secureStorage.read(kRefreshToken), 'new-refresh-token');
  });

  test(
    'logout clears all local session data when server logout fails',
    () async {
      final apiClient = _FakeApiClient((endPoint, data) async {
        throw ServerFailure('Server unavailable');
      });
      final repo = AuthRepoImpl(
        apiClient: apiClient,
        secureStorage: secureStorage,
      );
      await repo.saveUserToLocalStorage(_user());

      final result = await repo.logout();

      expect(result.isLeft(), isTrue);
      expect(Prefs.getString(kUserData), isEmpty);
      expect(await secureStorage.read(kAccessToken), isNull);
      expect(await secureStorage.read(kRefreshToken), isNull);
    },
  );
}

Map<String, dynamic> _sessionJson({
  String token = 'access-token',
  String refreshToken = 'refresh-token',
}) {
  final now = DateTime.now().toUtc();
  return {
    'token': token,
    'refreshToken': refreshToken,
    'expiresAt': now.add(const Duration(hours: 1)).toIso8601String(),
    'refreshTokenExpiresAt': now
        .add(const Duration(days: 30))
        .toIso8601String(),
    'id': 7,
    'username': 'ahmad',
    'fullNameAr': 'أحمد الخطيب',
    'fullNameEn': 'Ahmad Al-Khatib',
  };
}

UserEntity _user() {
  final now = DateTime.now().toUtc();
  return UserEntity(
    token: 'access-token',
    refreshToken: 'refresh-token',
    expiresAt: now.add(const Duration(hours: 1)),
    refreshTokenExpiresAt: now.add(const Duration(days: 30)),
    id: 7,
    username: 'ahmad',
    fullNameAr: 'أحمد الخطيب',
    fullNameEn: 'Ahmad Al-Khatib',
  );
}

class _FakeApiClient implements ApiClient {
  _FakeApiClient(this.onPost);

  final Future<Map<String, dynamic>> Function(String, Object?) onPost;
  int postCallCount = 0;

  @override
  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) {
    postCallCount++;
    return onPost(endPoint, data);
  }

  @override
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? query,
    Object? data,
  }) => throw UnimplementedError();
}
