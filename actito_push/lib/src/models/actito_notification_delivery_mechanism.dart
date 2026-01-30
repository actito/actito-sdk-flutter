import 'package:json_annotation/json_annotation.dart';

/// Indicates the delivery mechanism of a notification.
///
/// This enum is used to describe how a notification was delivered
/// to the device.
enum ActitoNotificationDeliveryMechanism {
  /// Standard delivery: the notification is displayed normally to the user,
  /// with alerts, sounds, or badges as configured.
  @JsonValue("standard")
  standard,

  /// Silent delivery: the notification is delivered silently without
  /// alerting the user.
  @JsonValue("silent")
  silent,
}
