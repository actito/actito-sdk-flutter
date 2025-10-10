import 'package:json_annotation/json_annotation.dart';

part 'actito_category_options.g.dart';

@JsonEnum(alwaysCreate: true)
enum ActitoCategoryOptions {
  @JsonValue("customDismissAction")
  customDismissAction,

  @JsonValue("allowInCarPlay")
  allowInCarPlay,

  @JsonValue("hiddenPreviewsShowTitle")
  hiddenPreviewsShowTitle,

  @JsonValue("hiddenPreviewsShowSubtitle")
  hiddenPreviewsShowSubtitle,

  @JsonValue("allowAnnouncement")
  allowAnnouncement;

  String toJson() => _$ActitoCategoryOptionsEnumMap[this]!;

  static List<String> toJsonList(List<ActitoCategoryOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
