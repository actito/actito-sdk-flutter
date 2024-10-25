// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_ranged_beacons_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoRangedBeaconsEvent _$ActitoRangedBeaconsEventFromJson(Map json) =>
    ActitoRangedBeaconsEvent(
      region: ActitoRegion.fromJson(
          Map<String, dynamic>.from(json['region'] as Map)),
      beacons: (json['beacons'] as List<dynamic>)
          .map((e) =>
              ActitoBeacon.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ActitoRangedBeaconsEventToJson(
        ActitoRangedBeaconsEvent instance) =>
    <String, dynamic>{
      'region': instance.region.toJson(),
      'beacons': instance.beacons.map((e) => e.toJson()).toList(),
    };
