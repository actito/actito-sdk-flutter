// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_custom_action_received_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoCustomActionReceivedEvent
    _$ActitoCustomActionReceivedEventFromJson(Map json) =>
        ActitoCustomActionReceivedEvent(
          notification: ActitoNotification.fromJson(
              Map<String, dynamic>.from(json['notification'] as Map)),
          action: ActitoNotificationAction.fromJson(
              Map<String, dynamic>.from(json['action'] as Map)),
          uri: json['uri'] as String,
        );

Map<String, dynamic> _$ActitoCustomActionReceivedEventToJson(
        ActitoCustomActionReceivedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
      'uri': instance.uri,
    };
