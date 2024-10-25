import 'package:json_annotation/json_annotation.dart';

part 'actito_unknown_notification_action_opened_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUnknownNotificationActionOpenedEvent {
  final Map<String, dynamic> notification;
  final String action;
  final String? responseText;

  ActitoUnknownNotificationActionOpenedEvent({
    required this.notification,
    required this.action,
    required this.responseText,
  });

  factory ActitoUnknownNotificationActionOpenedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoUnknownNotificationActionOpenedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoUnknownNotificationActionOpenedEventToJson(this);
}
