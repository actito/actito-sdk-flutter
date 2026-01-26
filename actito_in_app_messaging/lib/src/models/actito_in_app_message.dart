import 'package:json_annotation/json_annotation.dart';

part 'actito_in_app_message.g.dart';

/// Represents an in-app message delivered by Actito.
///
/// An [ActitoInAppMessage] defines content that can be displayed directly within
/// the application. Messages may include text, images, and actions for user interaction.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInAppMessage {
  /// Unique identifier of the in-app message.
  final String id;

  /// Human-readable name of the message.
  final String name;

  /// Type of the message.
  ///
  /// Supported message types:
  ///
  /// - `re.notifica.inappmessage.Banner`
  /// - `re.notifica.inappmessage.Card`
  /// - `re.notifica.inappmessage.Fullscreen`
  final String type;

  /// List of contexts where the message should be displayed.
  ///
  /// Supported contexts:
  ///
  /// - `launch` — displayed when the application is launched
  /// - `foreground` — displayed while the application is in the foreground
  final List<String> context;

  /// Optional title of the message.
  final String? title;

  /// Optional body text of the message.
  final String? message;

  /// Optional portrait image URL associated with the message.
  final String? image;

  /// Optional landscape image URL associated with the message.
  final String? landscapeImage;

  /// Delay before displaying the message, in seconds.
  final int delaySeconds;

  /// Optional primary action associated with the message.
  final ActitoInAppMessageAction? primaryAction;

  /// Optional secondary action associated with the message.
  final ActitoInAppMessageAction? secondaryAction;

  /// Constructor for [ActitoInAppMessage].
  ActitoInAppMessage({
    required this.id,
    required this.name,
    required this.type,
    required this.context,
    required this.title,
    required this.message,
    required this.image,
    required this.landscapeImage,
    required this.delaySeconds,
    required this.primaryAction,
    required this.secondaryAction,
  });

  /// Creates an [ActitoInAppMessage] from a JSON map.
  factory ActitoInAppMessage.fromJson(Map<String, dynamic> json) =>
      _$ActitoInAppMessageFromJson(json);

  /// Converts this [ActitoInAppMessage] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoInAppMessageToJson(this);
}

/// Represents an action associated with an in-app message.
///
/// An [ActitoInAppMessageAction] defines a user interaction option for an in-app
/// message, such as opening a URL or performing an operation.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInAppMessageAction {
  /// Optional label displayed for the action.
  final String? label;

  /// Indicates whether the action is destructive.
  final bool destructive;

  /// Optional target URL triggered by the action.
  final String? url;

  /// Constructor for [ActitoInAppMessageAction].
  ActitoInAppMessageAction({
    required this.label,
    required this.destructive,
    required this.url,
  });

  /// Creates an [ActitoInAppMessageAction] from a JSON map.
  factory ActitoInAppMessageAction.fromJson(Map<String, dynamic> json) =>
      _$ActitoInAppMessageActionFromJson(json);

  /// Converts this [ActitoInAppMessageAction] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoInAppMessageActionToJson(this);
}
