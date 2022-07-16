// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kline _$KlineFromJson(Map<String, dynamic> json) => Kline(
      success: json['success'] as bool,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => Row.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KlineToJson(Kline instance) => <String, dynamic>{
      'success': instance.success,
      'rows': instance.rows,
    };

Row _$RowFromJson(Map<String, dynamic> json) => Row(
      open: (json['open'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      symbol: json['symbol'] as String,
      type: json['type'] as String,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
    );

Map<String, dynamic> _$RowToJson(Row instance) => <String, dynamic>{
      'open': instance.open,
      'close': instance.close,
      'low': instance.low,
      'high': instance.high,
      'volume': instance.volume,
      'amount': instance.amount,
      'symbol': instance.symbol,
      'type': instance.type,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
    };
