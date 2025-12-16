import 'package:json_annotation/json_annotation.dart';

part 'actito_beacon.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoBeacon {
  final String id;
  final String name;
  final int major;
  final int? minor;
  final bool triggers;
  final String proximity;

  ActitoBeacon({
    required this.id,
    required this.name,
    required this.major,
    required this.minor,
    required this.triggers,
    required this.proximity,
  });

  factory ActitoBeacon.fromJson(Map<String, dynamic> json) =>
      _$ActitoBeaconFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoBeaconToJson(this);
}
