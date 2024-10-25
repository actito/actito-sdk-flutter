// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_executed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionExecutedEvent _$ActitoActionExecutedEventFromJson(
        Map json) =>
    ActitoActionExecutedEvent(
      message: ActitoInAppMessage.fromJson(
          Map<String, dynamic>.from(json['message'] as Map)),
      action: ActitoInAppMessageAction.fromJson(
          Map<String, dynamic>.from(json['action'] as Map)),
    );

Map<String, dynamic> _$ActitoActionExecutedEventToJson(
        ActitoActionExecutedEvent instance) =>
    <String, dynamic>{
      'message': instance.message.toJson(),
      'action': instance.action.toJson(),
    };
