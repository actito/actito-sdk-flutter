import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/converters/actito_iso_date_time_converter.dart';

part 'actito_notification.g.dart';

/// Represents a notification delivered by Actito.
///
/// An [ActitoNotification] contains the payload of a notification, including
/// its content, actions, attachments, and additional metadata.
/// Notifications may be partial, meaning that only a subset of fields is provided
/// and additional data may need to be fetched.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoNotification {
  /// Unique identifier of the notification.
  final String id;

  /// Indicates whether this notification is partial.
  ///
  /// When `true`, the notification does not contain the full payload.
  final bool partial;

  /// Type of the notification.
  ///
  /// This value is defined by Actito and is used to distinguish different
  /// notification behaviors.
  ///
  /// Supported notification types:
  ///
  /// - `re.notifica.notification.None`
  /// - `re.notifica.notification.Alert`
  /// - `re.notifica.notification.InAppBrowser`
  /// - `re.notifica.notification.WebView`
  /// - `re.notifica.notification.URL`
  /// - `re.notifica.notification.URLResolver`
  /// - `re.notifica.notification.URLScheme`
  /// - `re.notifica.notification.Image`
  /// - `re.notifica.notification.Video`
  /// - `re.notifica.notification.Map`
  /// - `re.notifica.notification.Rate`
  /// - `re.notifica.notification.Passbook`
  /// - `re.notifica.notification.Store`
  final String type;

  /// Timestamp indicating when the notification was generated.
  final DateTime time;

  /// Optional title displayed in the notification.
  final String? title;

  /// Optional subtitle displayed in the notification.
  final String? subtitle;

  /// Main message body of the notification.
  final String message;

  /// Structured content elements associated with the notification.
  final List<ActitoNotificationContent> content;

  /// List of actions that can be performed from the notification.
  final List<ActitoNotificationAction> actions;

  /// List of attachments included with the notification.
  final List<ActitoNotificationAttachment> attachments;

  /// Collection of key-value pairs used to add extra information to the notification.
  final Map<String, dynamic> extra;

  /// Optional identifier of the target content related to the notification.
  final String? targetContentIdentifier;

  /// Constructor for [ActitoNotification].
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

  /// Creates an [ActitoNotification] from a JSON map.
  factory ActitoNotification.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationFromJson(json);

  /// Converts this [ActitoNotification] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoNotificationToJson(this);
}

/// Represents a structured content element within a notification.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationContent {
  /// The content type identifier. These types include:
  ///
  /// Supported content types:
  ///
  /// - `re.notifica.content.HTML`
  /// - `re.notifica.content.PKPass`
  /// - `re.notifica.content.GooglePlayDetails`
  /// - `re.notifica.content.GooglePlayDeveloper`
  /// - `re.notifica.content.GooglePlaySearch`
  /// - `re.notifica.content.GooglePlayCollection`
  /// - `re.notifica.content.AppGalleryDetails`
  /// - `re.notifica.content.AppGallerySearch`
  final String type;

  /// The content payload.
  final dynamic data;

  /// Constructor for [ActitoNotificationContent].
  ActitoNotificationContent({
    required this.type,
    required this.data,
  });

  /// Creates an [ActitoNotificationContent] from a JSON map.
  factory ActitoNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationContentFromJson(json);

  /// Converts this [ActitoNotificationContent] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoNotificationContentToJson(this);
}

/// Represents an action that can be triggered from a notification.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationAction {
  /// Type of the action.
  ///
  /// Supported action types:
  ///
  /// - `re.notifica.action.App`
  /// - `re.notifica.action.Browser`
  /// - `re.notifica.action.Callback`
  /// - `re.notifica.action.Custom`
  /// - `re.notifica.action.Mail`
  /// - `re.notifica.action.SMS`
  /// - `re.notifica.action.Telephone`
  /// - `re.notifica.action.InAppBrowser`
  final String type;

  /// User-visible label of the action.
  final String label;

  /// Optional target associated with the action.
  final String? target;

  /// Whether the action requires keyboard input.
  final bool keyboard;

  /// Whether the action requires camera input.
  final bool camera;

  /// Whether the action is destructive.
  final bool? destructive;

  /// Optional platform-specific icon configuration for the action.
  final ActitoNotificationActionIcon? icon;

  /// Constructor for [ActitoNotificationAction].
  ActitoNotificationAction({
    required this.type,
    required this.label,
    required this.target,
    required this.keyboard,
    required this.camera,
    this.destructive,
    this.icon,
  });

  /// Creates an [ActitoNotificationAction] from a JSON map.
  factory ActitoNotificationAction.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationActionFromJson(json);

  /// Converts this [ActitoNotificationAction] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoNotificationActionToJson(this);
}

/// Defines platform-specific icons for a notification action.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationActionIcon {
  /// Resource identifier for Android.
  final String? android;

  /// Resource identifier for iOS.
  final String? ios;

  /// Resource identifier for Web.
  final String? web;

  /// Constructor for [ActitoNotificationActionIcon].
  ActitoNotificationActionIcon({
    this.android,
    this.ios,
    this.web,
  });

  /// Creates an [ActitoNotificationActionIcon] from a JSON map.
  factory ActitoNotificationActionIcon.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationActionIconFromJson(json);

  /// Converts this [ActitoNotificationActionIcon] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoNotificationActionIconToJson(this);
}

/// Represents an attachment included with a notification.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoNotificationAttachment {
  /// MIME type of the attachment.
  final String mimeType;

  /// URI pointing to the attachment resource.
  final String uri;

  /// Constructor for [ActitoNotificationAttachment].
  ActitoNotificationAttachment({
    required this.mimeType,
    required this.uri,
  });

  /// Creates an [ActitoNotificationAttachment] from a JSON map.
  factory ActitoNotificationAttachment.fromJson(Map<String, dynamic> json) =>
      _$ActitoNotificationAttachmentFromJson(json);

  /// Converts this [ActitoNotificationAttachment] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoNotificationAttachmentToJson(this);
}
