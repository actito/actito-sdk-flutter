// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_do_not_disturb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoDoNotDisturb _$ActitoDoNotDisturbFromJson(Map json) =>
    ActitoDoNotDisturb(
      start: ActitoTime.fromJson(json['start'] as String),
      end: ActitoTime.fromJson(json['end'] as String),
    );

Map<String, dynamic> _$ActitoDoNotDisturbToJson(
        ActitoDoNotDisturb instance) =>
    <String, dynamic>{
      'start': instance.start.toJson(),
      'end': instance.end.toJson(),
    };
