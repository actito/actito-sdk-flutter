import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/models/actito_notification.dart';

part 'actito_application.g.dart';

/// Represents an Actito application configuration.
///
/// An [ActitoApplication] describes the capabilities, services, and configuration
/// of an application as defined in Actito. It includes enabled services, region
/// and inbox configuration, available user data fields, and supported action categories.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoApplication {
  /// Unique identifier of the application.
  final String id;

  /// Name of the application.
  final String name;

  /// Category of the application as defined in Actito.
  final String category;

  /// Map of enabled services for the application.
  final Map<String, bool> services;

  /// Optional inbox-related configuration.
  final ActitoInboxConfig? inboxConfig;

  /// Optional region-related configuration.
  final ActitoRegionConfig? regionConfig;

  /// List of user data fields supported by the application.
  final List<ActitoUserDataField> userDataFields;

  /// List of action categories available in the application.
  final List<ActitoActionCategory> actionCategories;

  /// Constructor for [ActitoApplication].
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

  /// Creates an [ActitoApplication] from a JSON map.
  factory ActitoApplication.fromJson(Map<String, dynamic> json) =>
      _$ActitoApplicationFromJson(json);

  /// Converts this [ActitoApplication] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoApplicationToJson(this);
}

/// Configuration related to the Actito inbox feature.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoInboxConfig {
  /// Whether the inbox feature is enabled for the application.
  final bool useInbox;

  /// Whether unread inbox messages should automatically update the application
  /// badge count.
  final bool autoBadge;

  /// Constructor for [ActitoInboxConfig].
  ActitoInboxConfig({
    required this.useInbox,
    required this.autoBadge,
  });

  /// Creates an [ActitoInboxConfig] from a JSON map.
  factory ActitoInboxConfig.fromJson(Map<String, dynamic> json) =>
      _$ActitoInboxConfigFromJson(json);

  /// Converts this [ActitoInboxConfig] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoInboxConfigToJson(this);
}

/// Configuration related to region-based features.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoRegionConfig {
  /// Optional UUID used for beacon detection.
  final String? proximityUUID;

  /// Constructor for [ActitoRegionConfig].
  ActitoRegionConfig({
    this.proximityUUID,
  });

  /// Creates an [ActitoRegionConfig] from a JSON map.
  factory ActitoRegionConfig.fromJson(Map<String, dynamic> json) =>
      _$ActitoRegionConfigFromJson(json);

  /// Converts this [ActitoRegionConfig] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoRegionConfigToJson(this);
}

/// Describes a user data field supported by an Actito application.
///
/// User data fields define the structure of user attributes that can be
/// stored and leveraged for segmentation or personalization.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUserDataField {
  /// The data type of the field.
  final String type;

  /// The unique key identifying the field.
  final String key;

  /// Human-readable label for the field.
  final String label;

  /// Constructor for [ActitoUserDataField].
  ActitoUserDataField({
    required this.type,
    required this.key,
    required this.label,
  });

  /// Creates an [ActitoUserDataField] from a JSON map.
  factory ActitoUserDataField.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserDataFieldFromJson(json);

  /// Converts this [ActitoUserDataField] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoUserDataFieldToJson(this);
}

/// Groups related actions that can be triggered from notifications
/// or other engagement mechanisms.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoActionCategory {
  /// The category type identifier.
  final String type;

  /// The name of the action category.
  final String name;

  /// Optional description explaining the purpose of the category.
  final String? description;

  /// List of actions belonging to this category.
  final List<ActitoNotificationAction> actions;

  /// Constructor for [ActitoActionCategory].
  ActitoActionCategory({
    required this.type,
    required this.name,
    this.description,
    required this.actions,
  });

  /// Creates an [ActitoActionCategory] from a JSON map.
  factory ActitoActionCategory.fromJson(Map<String, dynamic> json) =>
      _$ActitoActionCategoryFromJson(json);

  /// Converts this [ActitoActionCategory] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoActionCategoryToJson(this);
}
