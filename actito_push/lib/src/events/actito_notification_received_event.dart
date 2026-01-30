import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

import '../models/actito_notification_delivery_mechanism.dart';

part 'actito_notification_received_event.g.dart';

/// Represents an event emitted when a notification is received.
///
/// This event is triggered when a notification is delivered to the device.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationReceivedEvent {
  /// Notification that was received.
  final ActitoNotification notification;

  /// Mechanism used to deliver the notification.
  final ActitoNotificationDeliveryMechanism deliveryMechanism;

  /// Constructor for [ActitoNotificationReceivedEvent].
  ActitoNotificationReceivedEvent({
    required this.notification,
    required this.deliveryMechanism,
  });

  /// Creates an [ActitoNotificationReceivedEvent] from a JSON map.
  factory ActitoNotificationReceivedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationReceivedEventFromJson(json);

  /// Converts this [ActitoNotificationReceivedEvent] to a JSON map.
  Map<String, dynamic> toJson() =>
      _$ActitoNotificationReceivedEventToJson(this);
}
