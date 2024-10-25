// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_action_failed_to_execute_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoActionFailedToExecuteEvent
    _$ActitoActionFailedToExecuteEventFromJson(Map json) =>
        ActitoActionFailedToExecuteEvent(
          message: ActitoInAppMessage.fromJson(
              Map<String, dynamic>.from(json['message'] as Map)),
          action: ActitoInAppMessageAction.fromJson(
              Map<String, dynamic>.from(json['action'] as Map)),
          error: json['error'] as String?,
        );

Map<String, dynamic> _$ActitoActionFailedToExecuteEventToJson(
        ActitoActionFailedToExecuteEvent instance) =>
    <String, dynamic>{
      'message': instance.message.toJson(),
      'action': instance.action.toJson(),
      'error': instance.error,
    };
