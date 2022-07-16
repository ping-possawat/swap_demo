import 'package:json_annotation/json_annotation.dart';
part 'available_token.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AvailableTokenResponse {
  AvailableTokenResponse({
    required this.success,
    required this.rows,
  });

  final bool success;
  final List<Token> rows;
  factory AvailableTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableTokenResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Token {
  Token({
    required this.createdTime,
    required this.updatedTime,
    required this.token,
    required this.balanceToken,
    required this.fullname,
    required this.decimals,
  });

  final String createdTime;
  final String updatedTime;
  final String token;
  final String balanceToken;
  final String fullname;
  final int decimals;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
