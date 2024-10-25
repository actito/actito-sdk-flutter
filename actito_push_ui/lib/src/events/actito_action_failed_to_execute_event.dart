import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_failed_to_execute_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionFailedToExecuteEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;
  final String? error;

  ActitoActionFailedToExecuteEvent({
    required this.notification,
    required this.action,
    required this.error,
  });

  factory ActitoActionFailedToExecuteEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionFailedToExecuteEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoActionFailedToExecuteEventToJson(this);
}
