import 'package:json_annotation/json_annotation.dart';

part 'actito_unknown_notification_action_opened_event.g.dart';

/// Represents an event emitted when an action is opened for an unknown notification.
///
/// This event is triggered when the SDK receives a notification action
/// interaction from an unknown notification.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUnknownNotificationActionOpenedEvent {
  /// Raw notification payload associated with the action.
  final Map<String, dynamic> notification;

  /// Identifier of the action that was opened.
  final String action;

  /// Optional text response provided by the user.
  final String? responseText;

  /// Constructor for [ActitoUnknownNotificationActionOpenedEvent].
  ActitoUnknownNotificationActionOpenedEvent({
    required this.notification,
    required this.action,
    required this.responseText,
  });

  /// Creates an [ActitoUnknownNotificationActionOpenedEvent] from a JSON map.
  factory ActitoUnknownNotificationActionOpenedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoUnknownNotificationActionOpenedEventFromJson(json);

  /// Converts this [ActitoUnknownNotificationActionOpenedEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoUnknownNotificationActionOpenedEventToJson(this);
}
