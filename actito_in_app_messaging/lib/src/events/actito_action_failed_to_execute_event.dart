import 'package:json_annotation/json_annotation.dart';
import 'package:actito_in_app_messaging/src/models/actito_in_app_message.dart';

part 'actito_action_failed_to_execute_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionFailedToExecuteEvent {
  final ActitoInAppMessage message;
  final ActitoInAppMessageAction action;
  final String? error;

  ActitoActionFailedToExecuteEvent({
    required this.message,
    required this.action,
    required this.error,
  });

  factory ActitoActionFailedToExecuteEvent.fromJson(
          Map<String, dynamic> json) =>
      _$ActitoActionFailedToExecuteEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoActionFailedToExecuteEventToJson(this);
}
