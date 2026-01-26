import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_custom_action_received_event.g.dart';

/// Represents an event emitted when a custom action is received from a notification.
///
/// This event is triggered when a user interacts with a notification action
/// of type `Custom`. It provides the associated notification, the action itself,
/// and the custom URI that should be handled by the app.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoCustomActionReceivedEvent {
  /// Notification that triggered the custom action.
  final ActitoNotification notification;

  /// The custom action that was received.
  final ActitoNotificationAction action;

  /// The URI associated with the custom action.
  final String uri;

  /// Constructor for [ActitoCustomActionReceivedEvent].
  ActitoCustomActionReceivedEvent({
    required this.notification,
    required this.action,
    required this.uri,
  });

  /// Creates an [ActitoCustomActionReceivedEvent] from a JSON map.
  factory ActitoCustomActionReceivedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoCustomActionReceivedEventFromJson(json);

  /// Converts this [ActitoCustomActionReceivedEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoCustomActionReceivedEventToJson(this);
}
