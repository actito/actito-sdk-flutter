// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_notification_received_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoNotificationReceivedEvent _$ActitoNotificationReceivedEventFromJson(
        Map json) =>
    ActitoNotificationReceivedEvent(
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      deliveryMechanism: $enumDecode(
          _$ActitoNotificationDeliveryMechanismEnumMap,
          json['deliveryMechanism']),
    );

Map<String, dynamic> _$ActitoNotificationReceivedEventToJson(
        ActitoNotificationReceivedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'deliveryMechanism': _$ActitoNotificationDeliveryMechanismEnumMap[
          instance.deliveryMechanism]!,
    };

const _$ActitoNotificationDeliveryMechanismEnumMap = {
  ActitoNotificationDeliveryMechanism.standard: 'standard',
  ActitoNotificationDeliveryMechanism.silent: 'silent',
};
