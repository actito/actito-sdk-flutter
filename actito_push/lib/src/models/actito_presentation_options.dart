import 'package:json_annotation/json_annotation.dart';

part 'actito_presentation_options.g.dart';

@JsonEnum(alwaysCreate: true)
enum ActitoPresentationOptions {
  @JsonValue("banner")
  banner,

  @JsonValue("alert")
  alert,

  @JsonValue("list")
  list,

  @JsonValue("badge")
  badge,

  @JsonValue("sound")
  sound;

  String toJson() => _$ActitoPresentationOptionsEnumMap[this]!;

  static List<String> toJsonList(List<ActitoPresentationOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
