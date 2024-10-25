import 'package:json_annotation/json_annotation.dart';

part 'actito_in_app_message.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInAppMessage {
  final String id;
  final String name;
  final String type;
  final List<String> context;
  final String? title;
  final String? message;
  final String? image;
  final String? landscapeImage;
  final int delaySeconds;
  final ActitoInAppMessageAction? primaryAction;
  final ActitoInAppMessageAction? secondaryAction;

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

  factory ActitoInAppMessage.fromJson(Map<String, dynamic> json) =>
      _$ActitoInAppMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoInAppMessageToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInAppMessageAction {
  final String? label;
  final bool destructive;
  final String? url;

  ActitoInAppMessageAction({
    required this.label,
    required this.destructive,
    required this.url,
  });

  factory ActitoInAppMessageAction.fromJson(Map<String, dynamic> json) =>
      _$ActitoInAppMessageActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoInAppMessageActionToJson(this);
}
