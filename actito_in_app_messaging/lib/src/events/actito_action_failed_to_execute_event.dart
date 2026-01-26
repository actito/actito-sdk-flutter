import 'package:json_annotation/json_annotation.dart';
import 'package:actito_in_app_messaging/src/models/actito_in_app_message.dart';

part 'actito_action_failed_to_execute_event.g.dart';

/// Represents an event emitted when an in-app message action fails to execute.
///
/// This event is triggered when the user interacts with an action associated with
/// an in-app message, but the action cannot be executed due to an error.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionFailedToExecuteEvent {
  /// In-app message for which the action execution failed.
  final ActitoInAppMessage message;

  /// Action that failed to execute.
  final ActitoInAppMessageAction action;

  /// Optional error message describing the reason for the failure.
  final String? error;

  /// Constructor for [ActitoActionFailedToExecuteEvent].
  ActitoActionFailedToExecuteEvent({
    required this.message,
    required this.action,
    required this.error,
  });

  /// Creates an [ActitoActionFailedToExecuteEvent] from a JSON map.
  factory ActitoActionFailedToExecuteEvent.fromJson(
          Map<String, dynamic> json) =>
      _$ActitoActionFailedToExecuteEventFromJson(json);

  /// Converts this [ActitoActionFailedToExecuteEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoActionFailedToExecuteEventToJson(this);
}
