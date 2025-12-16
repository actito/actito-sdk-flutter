import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/converters/actito_iso_date_time_converter.dart';

part 'actito_notification.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoNotification {
  final String id;
  final bool partial;
  final String type;
  final DateTime time;
  final String? title;
  final String? subtitle;
  final String message;
  final List<ActitoNotificationContent> content;
  final List<ActitoNotificationAction> actions;
  final List<ActitoNotificationAttachment> attachments;
  final Map<String, dynamic> extra;
  final String? targetContentIdentifier;

  ActitoNotification({
    required this.id,
    required this.partial,
    required this.type,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.content,
    required this.actions,
    required this.attachments,
    required this.extra,
    required this.targetContentIdentifier,
  });

  factory ActitoNotification.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoNotificationToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationContent {
  final String type;
  final dynamic data;

  ActitoNotificationContent({
    required this.type,
    required this.data,
  });

  factory ActitoNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationContentFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoNotificationContentToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationAction {
  final String type;
  final String label;
  final String? target;
  final bool keyboard;
  final bool camera;
  final bool? destructive;
  final ActitoNotificationActionIcon? icon;

  ActitoNotificationAction({
    required this.type,
    required this.label,
    required this.target,
    required this.keyboard,
    required this.camera,
    this.destructive,
    this.icon,
  });

  factory ActitoNotificationAction.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoNotificationActionToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationActionIcon {
  final String? android;
  final String? ios;
  final String? web;

  ActitoNotificationActionIcon({
    this.android,
    this.ios,
    this.web,
  });

  factory ActitoNotificationActionIcon.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationActionIconFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoNotificationActionIconToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationAttachment {
  final String mimeType;
  final String uri;

  ActitoNotificationAttachment({
    required this.mimeType,
    required this.uri,
  });

  factory ActitoNotificationAttachment.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoNotificationAttachmentToJson(this);
}
