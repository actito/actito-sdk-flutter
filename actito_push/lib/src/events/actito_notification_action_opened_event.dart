import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_notification_action_opened_event.g.dart';

/// Represents an event emitted when a notification action is opened.
///
/// This event is triggered when the user selects an action associated with a
/// notification.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationActionOpenedEvent {
  /// Notification for which the action was opened.
  final ActitoNotification notification;

  /// Action that was opened by the user.
  final ActitoNotificationAction action;

  /// Constructor for [ActitoNotificationActionOpenedEvent].
  ActitoNotificationActionOpenedEvent({
    required this.notification,
    required this.action,
  });

  /// Creates an [ActitoNotificationActionOpenedEvent] from a JSON map.
  factory ActitoNotificationActionOpenedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationActionOpenedEventFromJson(json);

  /// Converts this [ActitoNotificationActionOpenedEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoNotificationActionOpenedEventToJson(this);
}
