// To parse this JSON data, do
//
//     final tokenResponse = tokenResponseFromJson(jsonString);

import 'dart:convert';

TokenResponse tokenResponseFromJson(String str) => TokenResponse.fromJson(json.decode(str));

String tokenResponseToJson(TokenResponse data) => json.encode(data.toJson());

class TokenResponse {
  TokenResponse({
    this.token,
  });

  final Token token;

  TokenResponse copyWith({
    Token token,
  }) =>
      TokenResponse(
        token: token ?? this.token,
      );

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token.toJson(),
      };
}

class Token {
  Token({
    this.token,
    this.id,
  });

  final String token;
  final int id;

  Token copyWith({
    String token,
    int id,
  }) =>
      Token(
        token: token ?? this.token,
        id: id ?? this.id,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"] == null ? null : json["token"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "id": id == null ? null : id,
      };
}
