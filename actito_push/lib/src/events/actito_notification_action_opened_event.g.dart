// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_notification_action_opened_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoNotificationActionOpenedEvent
    _$ActitoNotificationActionOpenedEventFromJson(Map json) =>
        ActitoNotificationActionOpenedEvent(
          notification: ActitoNotification.fromJson(
              Map<String, dynamic>.from(json['notification'] as Map)),
          action: ActitoNotificationAction.fromJson(
              Map<String, dynamic>.from(json['action'] as Map)),
        );

Map<String, dynamic> _$ActitoNotificationActionOpenedEventToJson(
        ActitoNotificationActionOpenedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
    };
