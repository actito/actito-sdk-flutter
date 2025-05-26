// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_user_inbox_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoUserInboxItem _$ActitoUserInboxItemFromJson(Map json) =>
    ActitoUserInboxItem(
      id: json['id'] as String,
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      time: const ActitoIsoDateTimeConverter().fromJson(json['time'] as String),
      opened: json['opened'] as bool,
      expires: _$JsonConverterFromJson<String, DateTime>(
          json['expires'], const ActitoIsoDateTimeConverter().fromJson),
    );

Map<String, dynamic> _$ActitoUserInboxItemToJson(
        ActitoUserInboxItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notification': instance.notification.toJson(),
      'time': const ActitoIsoDateTimeConverter().toJson(instance.time),
      'opened': instance.opened,
      'expires': _$JsonConverterToJson<String, DateTime>(
          instance.expires, const ActitoIsoDateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
