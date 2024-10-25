import 'package:json_annotation/json_annotation.dart';
import 'package:actito_in_app_messaging/src/models/actito_in_app_message.dart';

part 'actito_action_executed_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionExecutedEvent {
  final ActitoInAppMessage message;
  final ActitoInAppMessageAction action;

  ActitoActionExecutedEvent({
    required this.message,
    required this.action,
  });

  factory ActitoActionExecutedEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionExecutedEventFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoActionExecutedEventToJson(this);
}
