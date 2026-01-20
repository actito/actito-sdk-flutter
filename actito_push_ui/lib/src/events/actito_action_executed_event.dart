import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_executed_event.g.dart';

/// Represents an event emitted when a notification action is successfully executed.
///
/// This event is triggered when the user interacts with an action associated
/// with a notification, and the action completes successfully.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionExecutedEvent {
  /// Notification that triggered the action.
  final ActitoNotification notification;

  /// Action that was executed by the user.
  final ActitoNotificationAction action;

  /// Constructor for [ActitoActionExecutedEvent].
  ActitoActionExecutedEvent({
    required this.notification,
    required this.action,
  });

  /// Creates an [ActitoActionExecutedEvent] from a JSON map.
  factory ActitoActionExecutedEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionExecutedEventFromJson(json);

  /// Converts this [ActitoActionExecutedEvent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoActionExecutedEventToJson(this);
}
