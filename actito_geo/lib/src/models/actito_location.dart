import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_location.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoLocation {
  final double latitude;
  final double longitude;
  final double altitude;
  final double course;
  final double speed;
  final int? floor;
  final double horizontalAccuracy;
  final double verticalAccuracy;
  final DateTime timestamp;

  ActitoLocation({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.course,
    required this.speed,
    required this.floor,
    required this.horizontalAccuracy,
    required this.verticalAccuracy,
    required this.timestamp,
  });

  factory ActitoLocation.fromJson(Map<String, dynamic> json) =>
      _$ActitoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoLocationToJson(this);
}
