import 'package:json_annotation/json_annotation.dart';

part 'actito_region.g.dart';

/// Represents a geographic region configured in Actito.
///
/// An [ActitoRegion] defines a location-based area that can be used for proximity
/// detection, geofencing, or region-triggered actions.
/// Regions may be defined using simple or advanced geometries.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegion {
  /// Unique identifier of the region.
  final String id;

  /// Human-readable name of the region.
  final String name;

  /// Optional description of the region.
  final String? description;

  /// Optional reference key associated with the region.
  final String? referenceKey;

  /// Primary geometry defining the region.
  final ActitoRegionGeometry geometry;

  /// Optional advanced geometry defining complex region shapes.
  final ActitoRegionAdvancedGeometry? advancedGeometry;

  /// Optional major value associated with the region.
  ///
  /// This is typically used for beacon-based regions.
  final int? major;

  /// Distance from the device to the region in meters.
  final double distance;

  /// Time zone identifier associated with the region.
  final String timeZone;

  /// Time zone offset of the region in hours relative to UTC.
  final double timeZoneOffset;

  /// Constructor for [ActitoRegion].
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

  /// Creates an [ActitoRegion] from a JSON map.
  factory ActitoRegion.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionFromJson(json);

  /// Converts this [ActitoRegion] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRegionToJson(this);
}

/// Defines the basic geometry of an Actito region.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionGeometry {
  /// Geometry type.
  final String type;

  /// Coordinate defining the geometry's reference point.
  final ActitoRegionCoordinate coordinate;

  /// Constructor for [ActitoRegionGeometry].
  ActitoRegionGeometry({
    required this.type,
    required this.coordinate,
  });

  /// Creates an [ActitoRegionGeometry] from a JSON map.
  factory ActitoRegionGeometry.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionGeometryFromJson(json);

  /// Converts this [ActitoRegionGeometry] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRegionGeometryToJson(this);
}

/// Defines an advanced geometry for complex region shapes.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionAdvancedGeometry {
  /// Geometry type.
  final String type;

  /// List of coordinates defining the geometry.
  final List<ActitoRegionCoordinate> coordinates;

  /// Constructor for [ActitoRegionAdvancedGeometry].
  ActitoRegionAdvancedGeometry({
    required this.type,
    required this.coordinates,
  });

  /// Creates an [ActitoRegionAdvancedGeometry] from a JSON map.
  factory ActitoRegionAdvancedGeometry.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoRegionAdvancedGeometryFromJson(json);

  /// Converts this [ActitoRegionAdvancedGeometry] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRegionAdvancedGeometryToJson(this);
}

/// Represents a geographic coordinate.
///
/// Coordinates are expressed in decimal degrees.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionCoordinate {
  /// Latitude in decimal degrees.
  final double latitude;
  /// Longitude in decimal degrees.
  final double longitude;

  /// Constructor for [ActitoRegionCoordinate].
  ActitoRegionCoordinate({
    required this.latitude,
    required this.longitude,
  });

  /// Creates an [ActitoRegionCoordinate] from a JSON map.
  factory ActitoRegionCoordinate.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionCoordinateFromJson(json);

  /// Converts this [ActitoRegionCoordinate] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRegionCoordinateToJson(this);
}
