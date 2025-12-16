// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_notification_url_clicked_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoNotificationUrlClickedEvent _$ActitoNotificationUrlClickedEventFromJson(
        Map json) =>
    ActitoNotificationUrlClickedEvent(
      notification: ActitoNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      url: json['url'] as String,
    );

Map<String, dynamic> _$ActitoNotificationUrlClickedEventToJson(
        ActitoNotificationUrlClickedEvent instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'url': instance.url,
    };
