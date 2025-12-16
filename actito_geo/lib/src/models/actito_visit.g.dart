// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoVisit _$ActitoVisitFromJson(Map json) => ActitoVisit(
      departureDate: const ActitoIsoDateTimeConverter()
          .fromJson(json['departureDate'] as String),
      arrivalDate: const ActitoIsoDateTimeConverter()
          .fromJson(json['arrivalDate'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$ActitoVisitToJson(ActitoVisit instance) =>
    <String, dynamic>{
      'departureDate':
          const ActitoIsoDateTimeConverter().toJson(instance.departureDate),
      'arrivalDate':
          const ActitoIsoDateTimeConverter().toJson(instance.arrivalDate),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
