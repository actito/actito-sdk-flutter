// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoNotification _$ActitoNotificationFromJson(Map json) => ActitoNotification(
      id: json['id'] as String,
      partial: json['partial'] as bool,
      type: json['type'] as String,
      time: const ActitoIsoDateTimeConverter().fromJson(json['time'] as String),
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      message: json['message'] as String,
      content: (json['content'] as List<dynamic>)
          .map((e) => ActitoNotificationContent.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => ActitoNotificationAction.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => ActitoNotificationAttachment.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      extra: Map<String, dynamic>.from(json['extra'] as Map),
      targetContentIdentifier: json['targetContentIdentifier'] as String?,
    );

Map<String, dynamic> _$ActitoNotificationToJson(ActitoNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partial': instance.partial,
      'type': instance.type,
      'time': const ActitoIsoDateTimeConverter().toJson(instance.time),
      'title': instance.title,
      'subtitle': instance.subtitle,
      'message': instance.message,
      'content': instance.content.map((e) => e.toJson()).toList(),
      'actions': instance.actions.map((e) => e.toJson()).toList(),
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'extra': instance.extra,
      'targetContentIdentifier': instance.targetContentIdentifier,
    };

ActitoNotificationContent _$ActitoNotificationContentFromJson(Map json) =>
    ActitoNotificationContent(
      type: json['type'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$ActitoNotificationContentToJson(
        ActitoNotificationContent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

ActitoNotificationAction _$ActitoNotificationActionFromJson(Map json) =>
    ActitoNotificationAction(
      type: json['type'] as String,
      label: json['label'] as String,
      target: json['target'] as String?,
      keyboard: json['keyboard'] as bool,
      camera: json['camera'] as bool,
      destructive: json['destructive'] as bool?,
      icon: json['icon'] == null
          ? null
          : ActitoNotificationActionIcon.fromJson(
              Map<String, dynamic>.from(json['icon'] as Map)),
    );

Map<String, dynamic> _$ActitoNotificationActionToJson(
        ActitoNotificationAction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'target': instance.target,
      'keyboard': instance.keyboard,
      'camera': instance.camera,
      'destructive': instance.destructive,
      'icon': instance.icon?.toJson(),
    };

ActitoNotificationActionIcon _$ActitoNotificationActionIconFromJson(Map json) =>
    ActitoNotificationActionIcon(
      android: json['android'] as String?,
      ios: json['ios'] as String?,
      web: json['web'] as String?,
    );

Map<String, dynamic> _$ActitoNotificationActionIconToJson(
        ActitoNotificationActionIcon instance) =>
    <String, dynamic>{
      'android': instance.android,
      'ios': instance.ios,
      'web': instance.web,
    };

ActitoNotificationAttachment _$ActitoNotificationAttachmentFromJson(Map json) =>
    ActitoNotificationAttachment(
      mimeType: json['mimeType'] as String,
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$ActitoNotificationAttachmentToJson(
        ActitoNotificationAttachment instance) =>
    <String, dynamic>{
      'mimeType': instance.mimeType,
      'uri': instance.uri,
    };
