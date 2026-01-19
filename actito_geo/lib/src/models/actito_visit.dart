import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_visit.g.dart';

/// Represents a recorded visit or stay at a specific location.
///
/// An [ActitoVisit] captures the geographic coordinates of the location along
/// with the arrival and departure timestamps. This is typically used for location
/// tracking, analytics, or region-based engagement.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoVisit {
  /// Timestamp when the visit ended.
  final DateTime departureDate;

  /// Timestamp when the visit started.
  final DateTime arrivalDate;

  /// Latitude of the visited location in decimal degrees.
  final double latitude;

  /// Longitude of the visited location in decimal degrees.
  final double longitude;

  /// Constructor for [ActitoVisit].
  ActitoVisit({
    required this.departureDate,
    required this.arrivalDate,
    required this.latitude,
    required this.longitude,
  });

  /// Creates an [ActitoVisit] from a JSON map.
  factory ActitoVisit.fromJson(Map<String, dynamic> json) =>
      _$ActitoVisitFromJson(json);

  /// Converts this [ActitoVisit] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoVisitToJson(this);
}
