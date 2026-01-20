import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_not_executed_event.g.dart';

/// Represents an event emitted when a notification action is available
/// but the user chooses not to execute it.
///
/// This event occurs when a user sees a notification with actions,
/// but explicitly dismisses or ignores the action instead of executing it.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionNotExecutedEvent {
  /// Notification associated with the action that was not executed.
  final ActitoNotification notification;

  /// Action that was not executed.
  final ActitoNotificationAction action;

  /// Constructor for [ActitoActionNotExecutedEvent].
  ActitoActionNotExecutedEvent({
    required this.notification,
    required this.action,
  });

  /// Creates an [ActitoActionNotExecutedEvent] from a JSON map.
  factory ActitoActionNotExecutedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionNotExecutedEventFromJson(json);

  /// Converts this [ActitoActionNotExecutedEvent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoActionNotExecutedEventToJson(this);
}
