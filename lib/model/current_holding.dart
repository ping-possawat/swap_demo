import 'package:json_annotation/json_annotation.dart';

part 'current_holding.g.dart';

@JsonSerializable()
class CurrentHolding {
  CurrentHolding({
    required this.success,
    required this.holding,
  });

  final bool success;
  final Map<String, double> holding;

  factory CurrentHolding.fromJson(Map<String, dynamic> json) =>
      _$CurrentHoldingFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentHoldingToJson(this);
}
