import 'package:json_annotation/json_annotation.dart';

part 'kline.g.dart';

@JsonSerializable()
class Kline {
  Kline({
    required this.success,
    required this.rows,
  });

  final bool success;
  final List<Row> rows;

  factory Kline.fromJson(Map<String, dynamic> json) => _$KlineFromJson(json);

  Map<String, dynamic> toJson() => _$KlineToJson(this);
}

@JsonSerializable()
class Row {
  Row({
    required this.open,
    required this.close,
    required this.low,
    required this.high,
    required this.volume,
    required this.amount,
    required this.symbol,
    required this.type,
    this.startTimestamp,
    this.endTimestamp,
  });

  final double open;
  final double close;
  final double low;
  final double high;
  final double volume;
  final double amount;
  final String symbol;
  final String type;
  final int? startTimestamp;
  final int? endTimestamp;
  factory Row.fromJson(Map<String, dynamic> json) => _$RowFromJson(json);

  Map<String, dynamic> toJson() => _$RowToJson(this);
}
