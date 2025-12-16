import 'package:json_annotation/json_annotation.dart';
import 'package:actito_geo/src/models/actito_beacon.dart';
import 'package:actito_geo/src/models/actito_region.dart';

part 'actito_ranged_beacons_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRangedBeaconsEvent {
  final ActitoRegion region;
  final List<ActitoBeacon> beacons;

  ActitoRangedBeaconsEvent({
    required this.region,
    required this.beacons,
  });

  factory ActitoRangedBeaconsEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoRangedBeaconsEventFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoRangedBeaconsEventToJson(this);
}
