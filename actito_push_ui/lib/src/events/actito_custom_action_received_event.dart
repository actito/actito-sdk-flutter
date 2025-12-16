import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_custom_action_received_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoCustomActionReceivedEvent {
  final ActitoNotification notification;
  final ActitoNotificationAction action;
  final String uri;

  ActitoCustomActionReceivedEvent({
    required this.notification,
    required this.action,
    required this.uri,
  });

  factory ActitoCustomActionReceivedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoCustomActionReceivedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoCustomActionReceivedEventToJson(this);
}
