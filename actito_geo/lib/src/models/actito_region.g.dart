// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoRegion _$ActitoRegionFromJson(Map json) => ActitoRegion(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      referenceKey: json['referenceKey'] as String?,
      geometry: ActitoRegionGeometry.fromJson(
          Map<String, dynamic>.from(json['geometry'] as Map)),
      advancedGeometry: json['advancedGeometry'] == null
          ? null
          : ActitoRegionAdvancedGeometry.fromJson(
              Map<String, dynamic>.from(json['advancedGeometry'] as Map)),
      major: json['major'] as int?,
      distance: (json['distance'] as num).toDouble(),
      timeZone: json['timeZone'] as String,
      timeZoneOffset: json['timeZoneOffset'] as int,
    );

Map<String, dynamic> _$ActitoRegionToJson(ActitoRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'referenceKey': instance.referenceKey,
      'geometry': instance.geometry.toJson(),
      'advancedGeometry': instance.advancedGeometry?.toJson(),
      'major': instance.major,
      'distance': instance.distance,
      'timeZone': instance.timeZone,
      'timeZoneOffset': instance.timeZoneOffset,
    };

ActitoRegionGeometry _$ActitoRegionGeometryFromJson(Map json) =>
    ActitoRegionGeometry(
      type: json['type'] as String,
      coordinate: ActitoRegionCoordinate.fromJson(
          Map<String, dynamic>.from(json['coordinate'] as Map)),
    );

Map<String, dynamic> _$ActitoRegionGeometryToJson(
        ActitoRegionGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinate': instance.coordinate.toJson(),
    };

ActitoRegionAdvancedGeometry _$ActitoRegionAdvancedGeometryFromJson(
        Map json) =>
    ActitoRegionAdvancedGeometry(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => ActitoRegionCoordinate.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ActitoRegionAdvancedGeometryToJson(
        ActitoRegionAdvancedGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates.map((e) => e.toJson()).toList(),
    };

ActitoRegionCoordinate _$ActitoRegionCoordinateFromJson(Map json) =>
    ActitoRegionCoordinate(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$ActitoRegionCoordinateToJson(
        ActitoRegionCoordinate instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
