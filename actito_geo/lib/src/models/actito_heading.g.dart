// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_heading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoHeading _$ActitoHeadingFromJson(Map json) => ActitoHeading(
      magneticHeading: (json['magneticHeading'] as num).toDouble(),
      trueHeading: (json['trueHeading'] as num).toDouble(),
      headingAccuracy: (json['headingAccuracy'] as num).toDouble(),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      z: (json['z'] as num).toDouble(),
      timestamp: const ActitoIsoDateTimeConverter()
          .fromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$ActitoHeadingToJson(ActitoHeading instance) =>
    <String, dynamic>{
      'magneticHeading': instance.magneticHeading,
      'trueHeading': instance.trueHeading,
      'headingAccuracy': instance.headingAccuracy,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'timestamp':
          const ActitoIsoDateTimeConverter().toJson(instance.timestamp),
    };
