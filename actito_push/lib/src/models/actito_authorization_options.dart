import 'package:json_annotation/json_annotation.dart';

part 'actito_authorization_options.g.dart';

@JsonEnum(alwaysCreate: true)
enum ActitoAuthorizationOptions {
  @JsonValue("alert")
  alert,

  @JsonValue("badge")
  badge,

  @JsonValue("sound")
  sound,

  @JsonValue("carPlay")
  carPlay,

  @JsonValue("providesAppNotificationSettings")
  providesAppNotificationSettings,

  @JsonValue("provisional")
  provisional,

  @JsonValue("criticalAlert")
  criticalAlert,

  @JsonValue("announcement")
  announcement;

  String toJson() => _$ActitoAuthorizationOptionsEnumMap[this]!;

  static List<String> toJsonList(List<ActitoAuthorizationOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
