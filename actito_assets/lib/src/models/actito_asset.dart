import 'package:json_annotation/json_annotation.dart';

part 'actito_asset.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAsset {
  final String title;
  final String? description;
  final String? key;
  final String? url;
  final ActitoAssetButton? button;
  final ActitoAssetMetaData? metaData;
  final Map<String, dynamic> extra;

  ActitoAsset({
    required this.title,
    required this.description,
    required this.key,
    required this.url,
    required this.button,
    required this.metaData,
    required this.extra,
  });

  factory ActitoAsset.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoAssetToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAssetButton {
  final String? label;
  final String? action;

  ActitoAssetButton({
    required this.label,
    required this.action,
  });

  factory ActitoAssetButton.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetButtonFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoAssetButtonToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAssetMetaData {
  final String originalFileName;
  final String contentType;
  final int contentLength;

  ActitoAssetMetaData({
    required this.originalFileName,
    required this.contentType,
    required this.contentLength,
  });

  factory ActitoAssetMetaData.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoAssetMetaDataToJson(this);
}
