// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_executed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionExecutedEvent _$ActitoActionExecutedEventFromJson(Map json) =>
    ActitoActionExecutedEvent(
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      action: ActitoNotificationAction.fromJson(
          Map<String, dynamic>.from(json['action'] as Map)),
    );

Map<String, dynamic> _$ActitoActionExecutedEventToJson(
        ActitoActionExecutedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
    };
