import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_executed_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionExecutedEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;

  ActitoActionExecutedEvent({
    required this.notification,
    required this.action,
  });

  factory ActitoActionExecutedEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionExecutedEventFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoActionExecutedEventToJson(this);
}
