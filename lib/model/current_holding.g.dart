// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentHolding _$CurrentHoldingFromJson(Map<String, dynamic> json) =>
    CurrentHolding(
      success: json['success'] as bool,
      holding: (json['holding'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CurrentHoldingToJson(CurrentHolding instance) =>
    <String, dynamic>{
      'success': instance.success,
      'holding': instance.holding,
    };
