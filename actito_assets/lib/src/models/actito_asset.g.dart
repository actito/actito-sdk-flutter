// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actito_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActitoAsset _$ActitoAssetFromJson(Map json) => ActitoAsset(
      title: json['title'] as String,
      description: json['description'] as String?,
      key: json['key'] as String?,
      url: json['url'] as String?,
      button: json['button'] == null
          ? null
          : ActitoAssetButton.fromJson(
              Map<String, dynamic>.from(json['button'] as Map)),
      metaData: json['metaData'] == null
          ? null
          : ActitoAssetMetaData.fromJson(
              Map<String, dynamic>.from(json['metaData'] as Map)),
      extra: Map<String, dynamic>.from(json['extra'] as Map),
    );

Map<String, dynamic> _$ActitoAssetToJson(ActitoAsset instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'key': instance.key,
      'url': instance.url,
      'button': instance.button?.toJson(),
      'metaData': instance.metaData?.toJson(),
      'extra': instance.extra,
    };

ActitoAssetButton _$ActitoAssetButtonFromJson(Map json) => ActitoAssetButton(
      label: json['label'] as String?,
      action: json['action'] as String?,
    );

Map<String, dynamic> _$ActitoAssetButtonToJson(ActitoAssetButton instance) =>
    <String, dynamic>{
      'label': instance.label,
      'action': instance.action,
    };

ActitoAssetMetaData _$ActitoAssetMetaDataFromJson(Map json) =>
    ActitoAssetMetaData(
      originalFileName: json['originalFileName'] as String,
      contentType: json['contentType'] as String,
      contentLength: json['contentLength'] as int,
    );

Map<String, dynamic> _$ActitoAssetMetaDataToJson(
        ActitoAssetMetaData instance) =>
    <String, dynamic>{
      'originalFileName': instance.originalFileName,
      'contentType': instance.contentType,
      'contentLength': instance.contentLength,
    };
