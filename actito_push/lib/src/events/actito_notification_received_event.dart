import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

import '../models/actito_notification_delivery_mechanism.dart';

part 'actito_notification_received_event.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationReceivedEvent {
  final ActitoNotification notification;
  final ActitoNotificationDeliveryMechanism deliveryMechanism;

  ActitoNotificationReceivedEvent({
    required this.notification,
    required this.deliveryMechanism,
  });

  factory ActitoNotificationReceivedEvent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ActitoNotificationReceivedEventFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ActitoNotificationReceivedEventToJson(this);
}
