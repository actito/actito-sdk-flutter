import 'package:json_annotation/json_annotation.dart';

part 'actito_region.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegion {
  final String id;
  final String name;
  final String? description;
  final String? referenceKey;
  final ActitoRegionGeometry geometry;
  final ActitoRegionAdvancedGeometry? advancedGeometry;
  final int? major;
  final double distance;
  final String timeZone;
  final int timeZoneOffset;

  ActitoRegion({
    required this.id,
    required this.name,
    required this.description,
    required this.referenceKey,
    required this.geometry,
    required this.advancedGeometry,
    required this.major,
    required this.distance,
    required this.timeZone,
    required this.timeZoneOffset,
  });

  factory ActitoRegion.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoRegionToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionGeometry {
  final String type;
  final ActitoRegionCoordinate coordinate;

  ActitoRegionGeometry({
    required this.type,
    required this.coordinate,
  });

  factory ActitoRegionGeometry.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoRegionGeometryToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionAdvancedGeometry {
  final String type;
  final List<ActitoRegionCoordinate> coordinates;

  ActitoRegionAdvancedGeometry({
    required this.type,
    required this.coordinates,
  });

  factory ActitoRegionAdvancedGeometry.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoRegionAdvancedGeometryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoRegionAdvancedGeometryToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionCoordinate {
  final double latitude;
  final double longitude;

  ActitoRegionCoordinate({
    required this.latitude,
    required this.longitude,
  });

  factory ActitoRegionCoordinate.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionCoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoRegionCoordinateToJson(this);
}
