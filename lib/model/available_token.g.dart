// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableTokenResponse _$AvailableTokenResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableTokenResponse(
      success: json['success'] as bool,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => Token.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableTokenResponseToJson(
        AvailableTokenResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'rows': instance.rows,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      createdTime: json['created_time'] as String,
      updatedTime: json['updated_time'] as String,
      token: json['token'] as String,
      balanceToken: json['balance_token'] as String,
      fullname: json['fullname'] as String,
      decimals: json['decimals'] as int,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
      'token': instance.token,
      'balance_token': instance.balanceToken,
      'fullname': instance.fullname,
      'decimals': instance.decimals,
    };
