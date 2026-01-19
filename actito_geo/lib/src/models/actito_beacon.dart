import 'package:json_annotation/json_annotation.dart';

part 'actito_beacon.g.dart';

/// Represents a beacon configured in Actito.
///
/// An [ActitoBeacon] describes a proximity beacon that can be used to trigger
/// proximity-based events.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoBeacon {
  /// Unique identifier of the beacon.
  final String id;

  /// Human-readable name of the beacon.
  final String name;

  /// Major value of the beacon.
  ///
  /// This value is used to group related beacons.
  final int major;

  /// Optional minor value of the beacon.
  ///
  /// When provided, this value identifies a specific beacon within a group.
  final int? minor;

  /// Indicates whether this beacon can be used in triggers.
  final bool triggers;

  /// Proximity level associated with the beacon.
  ///
  /// Supported proximity values:
  ///
  /// - `unknown`
  /// - `immediate`
  /// - `near`
  /// - `far`
  final String proximity;

  /// Constructor for [ActitoBeacon].
  ActitoBeacon({
    required this.id,
    required this.name,
    required this.major,
    required this.minor,
    required this.triggers,
    required this.proximity,
  });

  /// Creates an [ActitoBeacon] from a JSON map.
  factory ActitoBeacon.fromJson(Map<String, dynamic> json) =>
      _$ActitoBeaconFromJson(json);

  /// Converts this [ActitoBeacon] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoBeaconToJson(this);
}
