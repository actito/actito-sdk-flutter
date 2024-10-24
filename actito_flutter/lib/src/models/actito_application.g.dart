// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoApplication _$ActitoApplicationFromJson(Map json) =>
    ActitoApplication(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      services: Map<String, bool>.from(json['services'] as Map),
      inboxConfig: json['inboxConfig'] == null
          ? null
          : ActitoInboxConfig.fromJson(
              Map<String, dynamic>.from(json['inboxConfig'] as Map)),
      regionConfig: json['regionConfig'] == null
          ? null
          : ActitoRegionConfig.fromJson(
              Map<String, dynamic>.from(json['regionConfig'] as Map)),
      userDataFields: (json['userDataFields'] as List<dynamic>)
          .map((e) => ActitoUserDataField.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      actionCategories: (json['actionCategories'] as List<dynamic>)
          .map((e) => ActitoActionCategory.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ActitoApplicationToJson(
        ActitoApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'services': instance.services,
      'inboxConfig': instance.inboxConfig?.toJson(),
      'regionConfig': instance.regionConfig?.toJson(),
      'userDataFields': instance.userDataFields.map((e) => e.toJson()).toList(),
      'actionCategories':
          instance.actionCategories.map((e) => e.toJson()).toList(),
    };

ActitoInboxConfig _$ActitoInboxConfigFromJson(Map json) =>
    ActitoInboxConfig(
      useInbox: json['useInbox'] as bool,
      autoBadge: json['autoBadge'] as bool,
    );

Map<String, dynamic> _$ActitoInboxConfigToJson(
        ActitoInboxConfig instance) =>
    <String, dynamic>{
      'useInbox': instance.useInbox,
      'autoBadge': instance.autoBadge,
    };

ActitoRegionConfig _$ActitoRegionConfigFromJson(Map json) =>
    ActitoRegionConfig(
      proximityUUID: json['proximityUUID'] as String?,
    );

Map<String, dynamic> _$ActitoRegionConfigToJson(
        ActitoRegionConfig instance) =>
    <String, dynamic>{
      'proximityUUID': instance.proximityUUID,
    };

ActitoUserDataField _$ActitoUserDataFieldFromJson(Map json) =>
    ActitoUserDataField(
      type: json['type'] as String,
      key: json['key'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$ActitoUserDataFieldToJson(
        ActitoUserDataField instance) =>
    <String, dynamic>{
      'type': instance.type,
      'key': instance.key,
      'label': instance.label,
    };

ActitoActionCategory _$ActitoActionCategoryFromJson(Map json) =>
    ActitoActionCategory(
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      actions: (json['actions'] as List<dynamic>)
          .map((e) => ActitoNotificationAction.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ActitoActionCategoryToJson(
        ActitoActionCategory instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'actions': instance.actions.map((e) => e.toJson()).toList(),
    };
