import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_notification_url_clicked_event.g.dart';

/// Represents an event emitted when a user clicks on a URL associated with a notification.
///
/// This event is triggered when a notification contains a URL, and the user
/// interacts with it. It provides the original notification and the URL
/// that was clicked, allowing the app to handle navigation or other logic.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationUrlClickedEvent {
  /// Notification that contained the clicked URL.
  final ActitoNotification notification;

  /// URL that was clicked by the user.
  final String url;

  /// Constructor for [ActitoNotificationUrlClickedEvent].
  ActitoNotificationUrlClickedEvent({
    required this.notification,
    required this.url,
  });

  /// Creates an [ActitoNotificationUrlClickedEvent] from a JSON map.
  factory ActitoNotificationUrlClickedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationUrlClickedEventFromJson(json);

  /// Converts this [ActitoNotificationUrlClickedEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoNotificationUrlClickedEventToJson(this);
}
