import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_heading.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoHeading {
  final double magneticHeading;
  final double trueHeading;
  final double headingAccuracy;
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;

  ActitoHeading({
    required this.magneticHeading,
    required this.trueHeading,
    required this.headingAccuracy,
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  factory ActitoHeading.fromJson(Map<String, dynamic> json) =>
      _$ActitoHeadingFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoHeadingToJson(this);
}
