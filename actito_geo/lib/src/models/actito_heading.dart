import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_heading.g.dart';

/// Represents heading and orientation data captured from a device.
///
/// An [ActitoHeading] contains compass and motion sensor information that may be
/// used for location-aware features.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoHeading {
  /// Magnetic heading of the device in degrees.
  ///
  /// This value is relative to magnetic north.
  final double magneticHeading;

  /// True heading of the device in degrees.
  ///
  /// This value is relative to true north.
  final double trueHeading;

  /// Estimated accuracy of the heading measurement in degrees.
  final double headingAccuracy;

  /// X-axis component of the device's orientation vector.
  final double x;

  /// Y-axis component of the device's orientation vector.
  final double y;

  /// Z-axis component of the device's orientation vector.
  final double z;

  /// Timestamp indicating when the heading data was recorded.
  final DateTime timestamp;

  /// Constructor for [ActitoHeading].
  ActitoHeading({
    required this.magneticHeading,
    required this.trueHeading,
    required this.headingAccuracy,
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  /// Creates an [ActitoHeading] from a JSON map.
  factory ActitoHeading.fromJson(Map<String, dynamic> json) =>
      _$ActitoHeadingFromJson(json);

  /// Converts this [ActitoHeading] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoHeadingToJson(this);
}
