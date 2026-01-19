import 'package:json_annotation/json_annotation.dart';

part 'actito_asset.g.dart';

/// Represents a rich asset returned by Actito.
///
/// An [ActitoAsset] contains displayable content such as a title,
/// optional descriptive text, a link to a binary file, and elements like a button
/// or metadata. Additional fields are stored in [extra].
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAsset {
  /// The title of the asset.
  final String title;

  /// Optional description of the asset.
  final String? description;

  /// Optional key of the asset.
  final String? key;

  /// Optional binary file url of the asset.
  final String? url;

  /// Optional button associated with the asset.
  final ActitoAssetButton? button;

  /// Optional metadata associated with the asset.
  final ActitoAssetMetaData? metaData;

  /// Additional unstructured fields not explicitly modeled.
  final Map<String, dynamic> extra;

  /// Constructor for [ActitoAsset].
  ActitoAsset({
    required this.title,
    required this.description,
    required this.key,
    required this.url,
    required this.button,
    required this.metaData,
    required this.extra,
  });

  /// Creates an [ActitoAsset] from a JSON map.
  factory ActitoAsset.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetFromJson(json);

  /// Converts this [ActitoAsset] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoAssetToJson(this);
}

/// Represents a call-to-action button associated with an [ActitoAsset].
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAssetButton {
  /// Optional text displayed on the button.
  final String? label;

  /// Optional action associated with the button.
  final String? action;

  /// Constructor for [ActitoAssetButton].
  ActitoAssetButton({
    required this.label,
    required this.action,
  });

  /// Creates an [ActitoAssetButton] from a JSON map.
  factory ActitoAssetButton.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetButtonFromJson(json);

  /// Converts this [ActitoAssetButton] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoAssetButtonToJson(this);
}
/// Contains metadata describing the underlying file of an [ActitoAsset].
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoAssetMetaData {
  /// The original name of the file as provided at upload time.
  final String originalFileName;

  /// The MIME type of the file (for example, `image/png` or `application/pdf`).
  final String contentType;

  /// The size of the file in bytes.
  final int contentLength;

  /// Constructor for [ActitoAssetMetaData].
  ActitoAssetMetaData({
    required this.originalFileName,
    required this.contentType,
    required this.contentLength,
  });

  /// Creates an [ActitoAssetMetaData] from a JSON map.
  factory ActitoAssetMetaData.fromJson(Map<String, dynamic> json) =>
      _$ActitoAssetMetaDataFromJson(json);

  /// Converts this [ActitoAssetMetaData] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoAssetMetaDataToJson(this);
}
