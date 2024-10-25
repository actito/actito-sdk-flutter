// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_failed_to_execute_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionFailedToExecuteEvent
    _$ActitoActionFailedToExecuteEventFromJson(Map json) =>
        ActitoActionFailedToExecuteEvent(
          notification: ActitoNotification.fromJson(
              Map<String, dynamic>.from(json['notification'] as Map)),
          action: ActitoNotificationAction.fromJson(
              Map<String, dynamic>.from(json['action'] as Map)),
          error: json['error'] as String?,
        );

Map<String, dynamic> _$ActitoActionFailedToExecuteEventToJson(
        ActitoActionFailedToExecuteEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
      'error': instance.error,
    };
