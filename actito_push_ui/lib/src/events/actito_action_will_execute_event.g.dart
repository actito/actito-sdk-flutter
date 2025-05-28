// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_will_execute_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionWillExecuteEvent _$ActitoActionWillExecuteEventFromJson(Map json) =>
    ActitoActionWillExecuteEvent(
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      action: ActitoNotificationAction.fromJson(
          Map<String, dynamic>.from(json['action'] as Map)),
    );

Map<String, dynamic> _$ActitoActionWillExecuteEventToJson(
        ActitoActionWillExecuteEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
    };
