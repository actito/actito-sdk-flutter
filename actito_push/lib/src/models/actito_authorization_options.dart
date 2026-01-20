import 'package:json_annotation/json_annotation.dart';

part 'actito_authorization_options.g.dart';

/// iOS-specific authorization options used when requesting notification permissions.
///
/// These options map directly to iOS notification authorization settings.
@JsonEnum(alwaysCreate: true)
enum ActitoAuthorizationOptions {
  /// Allows the app to display alert notifications.
  @JsonValue("alert")
  alert,

  /// Allows the app to update the app icon badge.
  @JsonValue("badge")
  badge,

  /// Allows the app to play notification sounds.
  @JsonValue("sound")
  sound,

  /// Allows notifications to be displayed in CarPlay.
  @JsonValue("carPlay")
  carPlay,

  /// Allows the app to provide custom notification settings.
  @JsonValue("providesAppNotificationSettings")
  providesAppNotificationSettings,

  /// Allows the ability to post noninterrupting notifications provisionally to
  /// the Notification Center.
@JsonValue("provisional")
  provisional,

  /// Allows the app to play sounds for critical alerts.
  @JsonValue("criticalAlert")
  criticalAlert,

  /// Allows notifications to be announced using voice assistance.
  @JsonValue("announcement")
  announcement;

  /// Converts this option to its JSON string representation.
  String toJson() => _$ActitoAuthorizationOptionsEnumMap[this]!;

  /// Converts a list of [ActitoAuthorizationOptions] to a list of JSON strings.
  static List<String> toJsonList(List<ActitoAuthorizationOptions> options) =>
      options.map((e) => e.toJson()).toList();
}
