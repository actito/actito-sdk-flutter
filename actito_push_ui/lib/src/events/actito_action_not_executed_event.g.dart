// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_not_executed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionNotExecutedEvent _$ActitoActionNotExecutedEventFromJson(
        Map json) =>
    ActitoActionNotExecutedEvent(
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      action: ActitoNotificationAction.fromJson(
          Map<String, dynamic>.from(json['action'] as Map)),
    );

Map<String, dynamic> _$ActitoActionNotExecutedEventToJson(
        ActitoActionNotExecutedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'action': instance.action.toJson(),
    };
