import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_not_executed_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionNotExecutedEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;

  ActitoActionNotExecutedEvent({
    required this.notification,
    required this.action,
  });

  factory ActitoActionNotExecutedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionNotExecutedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoActionNotExecutedEventToJson(this);
}
