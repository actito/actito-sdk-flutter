// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_system_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoSystemNotification _$ActitoSystemNotificationFromJson(Map json) =>
    ActitoSystemNotification(
      id: json['id'] as String,
      type: json['type'] as String,
      extra: Map<String, String?>.from(json['extra'] as Map),
    );

Map<String, dynamic> _$ActitoSystemNotificationToJson(
        ActitoSystemNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'extra': instance.extra,
    };
