import 'package:json_annotation/json_annotation.dart';

part 'actito_presentation_options.g.dart';

/// iOS-specific options that control how a notification is presented
/// when the app is in the foreground.
@JsonEnum(alwaysCreate: true)
enum ActitoPresentationOptions {
  /// Displays the notification as a banner.
  @JsonValue("banner")
  banner,

  /// Displays the notification as an alert.
  @JsonValue("alert")
  alert,

  /// Displays the notification in the Notification Center.
  @JsonValue("list")
  list,

  /// Updates the app icon badge when the notification is delivered.
  @JsonValue("badge")
  badge,

  /// Plays a sound when the notification is delivered.
  @JsonValue("sound")
  sound;

  /// Converts this option to its JSON string representation.
  String toJson() => _$ActitoPresentationOptionsEnumMap[this]!;

  /// Converts a list of [ActitoPresentationOptions] to a list of JSON strings.
  static List<String> toJsonList(List<ActitoPresentationOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
