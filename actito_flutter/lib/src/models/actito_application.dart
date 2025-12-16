import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/models/actito_notification.dart';

part 'actito_application.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoApplication {
  final String id;
  final String name;
  final String category;
  final Map<String, bool> services;
  final ActitoInboxConfig? inboxConfig;
  final ActitoRegionConfig? regionConfig;
  final List<ActitoUserDataField> userDataFields;
  final List<ActitoActionCategory> actionCategories;

  ActitoApplication({
    required this.id,
    required this.name,
    required this.category,
    required this.services,
    this.inboxConfig,
    this.regionConfig,
    required this.userDataFields,
    required this.actionCategories,
  });

  factory ActitoApplication.fromJson(Map<String, dynamic> json) =>
      _$ActitoApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoApplicationToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInboxConfig {
  final bool useInbox;
  final bool autoBadge;

  ActitoInboxConfig({
    required this.useInbox,
    required this.autoBadge,
  });

  factory ActitoInboxConfig.fromJson(Map<String, dynamic> json) =>
      _$ActitoInboxConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoInboxConfigToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionConfig {
  final String? proximityUUID;

  ActitoRegionConfig({
    this.proximityUUID,
  });

  factory ActitoRegionConfig.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoRegionConfigToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUserDataField {
  final String type;
  final String key;
  final String label;

  ActitoUserDataField({
    required this.type,
    required this.key,
    required this.label,
  });

  factory ActitoUserDataField.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserDataFieldFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoUserDataFieldToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionCategory {
  final String type;
  final String name;
  final String? description;
  final List<ActitoNotificationAction> actions;

  ActitoActionCategory({
    required this.type,
    required this.name,
    this.description,
    required this.actions,
  });

  factory ActitoActionCategory.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoActionCategoryToJson(this);
}
