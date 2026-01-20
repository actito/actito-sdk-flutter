import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_action_will_execute_event.g.dart';

/// Represents an event emitted just before a notification action is executed.
///
/// This event is triggered when the user initiates an action associated
/// with a notification, but before the action is actually performed.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionWillExecuteEvent {
  /// Notification associated with the action about to be executed.
  final ActitoNotification notification;

  /// Action that is about to be executed.
  final ActitoNotificationAction action;

  /// Constructor for [ActitoActionWillExecuteEvent].
  ActitoActionWillExecuteEvent({
    required this.notification,
    required this.action,
  });

  /// Creates an [ActitoActionWillExecuteEvent] from a JSON map.
  factory ActitoActionWillExecuteEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoActionWillExecuteEventFromJson(json);

  /// Converts this [ActitoActionWillExecuteEvent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoActionWillExecuteEventToJson(this);
}
