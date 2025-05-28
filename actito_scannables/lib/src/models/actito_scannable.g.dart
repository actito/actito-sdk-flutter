// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_scannable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoScannable _$ActitoScannableFromJson(Map json) => ActitoScannable(
      id: json['id'] as String,
      name: json['name'] as String,
      tag: json['tag'] as String,
      type: json['type'] as String,
      notification: json['notification'] == null
          ? null
          : ActitoNotification.fromJson(
              Map<String, dynamic>.from(json['notification'] as Map)),
    );

Map<String, dynamic> _$ActitoScannableToJson(ActitoScannable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag': instance.tag,
      'type': instance.type,
      'notification': instance.notification?.toJson(),
    };
