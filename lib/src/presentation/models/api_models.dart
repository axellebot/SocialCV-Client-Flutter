class AccessTokenViewModelModel {
  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresAt;
  final String tokenType;

  AccessTokenViewModelModel({
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpiresAt,
    this.tokenType,
  }) : super();

  @override
  String toString() => '$runtimeType{ '
      'accessToken: $accessToken, '
      'refreshToken: $refreshToken, '
      'accessTokenExpiresAt: $accessTokenExpiresAt, '
      'tokenType: $tokenType'
      ' }';
}
