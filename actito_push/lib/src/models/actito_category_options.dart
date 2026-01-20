import 'package:json_annotation/json_annotation.dart';

part 'actito_category_options.g.dart';

/// iOS-specific notification category options.
///
/// These options configure the behavior and presentation of notification
/// categories on iOS.
@JsonEnum(alwaysCreate: true)
enum ActitoCategoryOptions {
  /// Adds a custom dismiss action to the notification category.
  @JsonValue("customDismissAction")
  customDismissAction,

  /// Allows notifications in this category to be displayed in CarPlay.
  @JsonValue("allowInCarPlay")
  allowInCarPlay,

  /// Displays the notification title when previews are hidden.
  @JsonValue("hiddenPreviewsShowTitle")
  hiddenPreviewsShowTitle,

  /// Displays the notification subtitle when previews are hidden.
  @JsonValue("hiddenPreviewsShowSubtitle")
  hiddenPreviewsShowSubtitle,

  /// Allows notifications in this category to be announced using voice assistance.
  @JsonValue("allowAnnouncement")
  allowAnnouncement;

  /// Converts this option to its JSON string representation.
  String toJson() => _$ActitoCategoryOptionsEnumMap[this]!;

  /// Converts a list of [ActitoCategoryOptions] to a list of JSON strings.
  static List<String> toJsonList(List<ActitoCategoryOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
