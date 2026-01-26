import 'package:json_annotation/json_annotation.dart';

part 'actito_push_subscription.g.dart';

/// Represents a push notification subscription for a device.
///
/// An [ActitoPushSubscription] stores the push token that allows Actito to send
/// push notifications to the device.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoPushSubscription {
  /// Device push token used to receive notifications.
  ///
  /// This may be null if the device has not yet registered for push notifications.
  final String? token;

  /// Constructor for [ActitoPushSubscription].
  ActitoPushSubscription({required this.token});

  /// Creates an [ActitoPushSubscription] from a JSON map.
  factory ActitoPushSubscription.fromJson(Map<String, dynamic> json) =>
      _$ActitoPushSubscriptionFromJson(json);

  /// Converts this [ActitoPushSubscription] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoPushSubscriptionToJson(this);
}
