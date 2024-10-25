import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_will_execute_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionWillExecuteEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;

  ActitoActionWillExecuteEvent({
    required this.notification,
    required this.action,
  });

  factory ActitoActionWillExecuteEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionWillExecuteEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoActionWillExecuteEventToJson(this);
}
