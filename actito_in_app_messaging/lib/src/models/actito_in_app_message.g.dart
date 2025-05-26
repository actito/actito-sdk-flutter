// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_in_app_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoInAppMessage _$ActitoInAppMessageFromJson(Map json) => ActitoInAppMessage(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      context:
          (json['context'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      image: json['image'] as String?,
      landscapeImage: json['landscapeImage'] as String?,
      delaySeconds: json['delaySeconds'] as int,
      primaryAction: json['primaryAction'] == null
          ? null
          : ActitoInAppMessageAction.fromJson(
              Map<String, dynamic>.from(json['primaryAction'] as Map)),
      secondaryAction: json['secondaryAction'] == null
          ? null
          : ActitoInAppMessageAction.fromJson(
              Map<String, dynamic>.from(json['secondaryAction'] as Map)),
    );

Map<String, dynamic> _$ActitoInAppMessageToJson(ActitoInAppMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'context': instance.context,
      'title': instance.title,
      'message': instance.message,
      'image': instance.image,
      'landscapeImage': instance.landscapeImage,
      'delaySeconds': instance.delaySeconds,
      'primaryAction': instance.primaryAction?.toJson(),
      'secondaryAction': instance.secondaryAction?.toJson(),
    };

ActitoInAppMessageAction _$ActitoInAppMessageActionFromJson(Map json) =>
    ActitoInAppMessageAction(
      label: json['label'] as String?,
      destructive: json['destructive'] as bool,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ActitoInAppMessageActionToJson(
        ActitoInAppMessageAction instance) =>
    <String, dynamic>{
      'label': instance.label,
      'destructive': instance.destructive,
      'url': instance.url,
    };
