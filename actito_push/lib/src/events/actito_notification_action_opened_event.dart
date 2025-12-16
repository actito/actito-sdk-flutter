import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_notification_action_opened_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationActionOpenedEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;

  ActitoNotificationActionOpenedEvent({
    required this.notification,
    required this.action,
  });

  factory ActitoNotificationActionOpenedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationActionOpenedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoNotificationActionOpenedEventToJson(this);
}
