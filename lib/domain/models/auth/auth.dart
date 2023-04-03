class Auth {
  Auth({
    required this.userId,
    required this.token,
    required this.expireDate,
    required this.refreshToken,
  });

  final String userId;
  final String token;
  final DateTime expireDate;
  final String refreshToken;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    userId: json["userId"],
    token: json["token"],
    expireDate: DateTime.parse(json["expireDate"]),
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "token": token,
    "expireDate": expireDate.toIso8601String(),
    "refreshToken": refreshToken
  };
}