import 'package:json_annotation/json_annotation.dart';
import 'package:actito_in_app_messaging/src/models/actito_in_app_message.dart';

part 'actito_action_executed_event.g.dart';

/// Represents an event emitted when an in-app message action is executed.
///
/// This event is triggered when the user interacts with an action (primary or
/// secondary) associated with an in-app message.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionExecutedEvent {
  /// In-app message for which the action was executed.
  final ActitoInAppMessage message;

  /// Action that was executed by the user.
  final ActitoInAppMessageAction action;

  /// Constructor for [ActitoActionExecutedEvent].
  ActitoActionExecutedEvent({
    required this.message,
    required this.action,
  });

  /// Creates an [ActitoActionExecutedEvent] from a JSON map.
  factory ActitoActionExecutedEvent.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionExecutedEventFromJson(json);

  /// Converts this [ActitoActionExecutedEvent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoActionExecutedEventToJson(this);
}
