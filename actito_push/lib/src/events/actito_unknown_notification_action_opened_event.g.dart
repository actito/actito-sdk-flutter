// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_unknown_notification_action_opened_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoUnknownNotificationActionOpenedEvent
    _$ActitoUnknownNotificationActionOpenedEventFromJson(Map json) =>
        ActitoUnknownNotificationActionOpenedEvent(
          notification: Map<String, dynamic>.from(json['notification'] as Map),
          action: json['action'] as String,
          responseText: json['responseText'] as String?,
        );

Map<String, dynamic> _$ActitoUnknownNotificationActionOpenedEventToJson(
        ActitoUnknownNotificationActionOpenedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'action': instance.action,
      'responseText': instance.responseText,
    };
