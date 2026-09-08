import 'package:triosuite_invoice_erp/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String token;
  final String refreshToken;
  final String expiresAt;
  final String refreshTokenExpiresAt;
  final int id;
  final String username;
  final String fullNameAr;
  final String fullNameEn;

  UserModel({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.refreshTokenExpiresAt,
    required this.id,
    required this.username,
    required this.fullNameAr,
    required this.fullNameEn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: json['expiresAt'] as String,
      refreshTokenExpiresAt: json['refreshTokenExpiresAt'] as String,
      id: json['id'] as int,
      username: json['username'] as String,
      fullNameAr: json['fullNameAr'] as String,
      fullNameEn: json['fullNameEn'] as String,
    );
  }

  factory UserModel.fromLocalJson(
    Map<String, dynamic> json, {
    String token = '',
    String refreshToken = '',
  }) {
    return UserModel(
      token: token,
      refreshToken: refreshToken,
      expiresAt: json['expiresAt'] as String,
      refreshTokenExpiresAt: json['refreshTokenExpiresAt'] as String,
      id: json['id'] as int,
      username: json['username'] as String,
      fullNameAr: json['fullNameAr'] as String,
      fullNameEn: json['fullNameEn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt,
      'refreshTokenExpiresAt': refreshTokenExpiresAt,
      'id': id,
      'username': username,
      'fullNameAr': fullNameAr,
      'fullNameEn': fullNameEn,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'expiresAt': expiresAt,
      'refreshTokenExpiresAt': refreshTokenExpiresAt,
      'id': id,
      'username': username,
      'fullNameAr': fullNameAr,
      'fullNameEn': fullNameEn,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      token: token,
      refreshToken: refreshToken,
      expiresAt: DateTime.parse(expiresAt),
      refreshTokenExpiresAt: DateTime.parse(refreshTokenExpiresAt),
      id: id,
      username: username,
      fullNameAr: fullNameAr,
      fullNameEn: fullNameEn,
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      token: user.token,
      refreshToken: user.refreshToken,
      expiresAt: user.expiresAt.toIso8601String(),
      refreshTokenExpiresAt: user.refreshTokenExpiresAt.toIso8601String(),
      id: user.id,
      username: user.username,
      fullNameAr: user.fullNameAr,
      fullNameEn: user.fullNameEn,
    );
  }
}
