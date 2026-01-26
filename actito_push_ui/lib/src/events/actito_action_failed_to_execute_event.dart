import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_failed_to_execute_event.g.dart';

/// Represents an event emitted when a notification action fails to execute.
///
/// This event is triggered when the user interacts with an action associated
/// with a notification, but the action could not be completed due to an error.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionFailedToExecuteEvent {
  /// Notification that triggered the failed action.
  final ActitoNotification notification;

  /// Action that failed to execute.
  final ActitoNotificationAction action;

  /// Optional error message describing the reason for the failure.
  final String? error;

  /// Constructor for [ActitoActionFailedToExecuteEvent].
  ActitoActionFailedToExecuteEvent({
    required this.notification,
    required this.action,
    required this.error,
  });

  /// Creates an [ActitoActionFailedToExecuteEvent] from a JSON map.
  factory ActitoActionFailedToExecuteEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionFailedToExecuteEventFromJson(json);

  /// Converts this [ActitoActionFailedToExecuteEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoActionFailedToExecuteEventToJson(this);
}
