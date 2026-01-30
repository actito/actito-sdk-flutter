import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_location.g.dart';

/// Represents a geographic location captured from a device.
///
/// An [ActitoLocation] contains latitude, longitude, altitude, movement, and
/// accuracy information, along with a timestamp indicating when the location was
/// recorded.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoLocation {
  /// Latitude of the location in decimal degrees.
  final double latitude;

  /// Longitude of the location in decimal degrees.
  final double longitude;

  /// Altitude of the location in meters above sea level.
  final double altitude;

  /// Direction of travel in degrees relative to true north.
  ///
  /// This value represents the device's course of movement.
  final double course;

  /// Speed of the device in meters per second.
  final double speed;

  /// Optional floor level of the location.
  ///
  /// This is typically used for indoor positioning systems.
  final int? floor;

  /// Horizontal accuracy of the location measurement in meters.
  final double horizontalAccuracy;

  /// Vertical accuracy of the location measurement in meters.
  final double verticalAccuracy;

  /// Timestamp indicating when the location was recorded.
  final DateTime timestamp;

  /// Constructor for [ActitoLocation].
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

  /// Creates an [ActitoLocation] from a JSON map.
  factory ActitoLocation.fromJson(Map<String, dynamic> json) =>
      _$ActitoLocationFromJson(json);

  /// Converts this [ActitoLocation] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoLocationToJson(this);
}
