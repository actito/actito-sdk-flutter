import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_notification_url_clicked_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationUrlClickedEvent {
  final ActitoNotification notification;
  final String url;

  ActitoNotificationUrlClickedEvent({
    required this.notification,
    required this.url,
  });

  factory ActitoNotificationUrlClickedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationUrlClickedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoNotificationUrlClickedEventToJson(this);
}
