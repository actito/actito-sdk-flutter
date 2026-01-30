import 'package:json_annotation/json_annotation.dart';
import 'package:actito_geo/src/models/actito_beacon.dart';
import 'package:actito_geo/src/models/actito_region.dart';

part 'actito_ranged_beacons_event.g.dart';

/// Represents a beacon ranging event within a specific region.
///
/// A ranged beacons event is emitted when beacons are detected inside a monitored
/// region, providing the list of currently visible beacons and their proximity
/// information.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRangedBeaconsEvent {
  /// Region in which the beacons were detected.
  final ActitoRegion region;

  /// List of beacons detected within the region.
  final List<ActitoBeacon> beacons;

  /// Constructor for [ActitoRangedBeaconsEvent].
  ActitoRangedBeaconsEvent({
    required this.region,
    required this.beacons,
  });

  /// Creates an [ActitoRangedBeaconsEvent] from a JSON map.
  factory ActitoRangedBeaconsEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoRangedBeaconsEventFromJson(json);

  /// Converts this [ActitoRangedBeaconsEvent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRangedBeaconsEventToJson(this);
}
