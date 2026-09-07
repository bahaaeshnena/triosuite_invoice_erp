class UserEntity {
  final String token;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime refreshTokenExpiresAt;
  final int id;
  final String username;
  final String fullNameAr;
  final String fullNameEn;

  const UserEntity({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.refreshTokenExpiresAt,
    required this.id,
    required this.username,
    required this.fullNameAr,
    required this.fullNameEn,
  });
}
