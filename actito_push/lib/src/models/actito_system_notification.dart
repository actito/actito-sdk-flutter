import 'package:json_annotation/json_annotation.dart';

part 'actito_system_notification.g.dart';

/// Represents a system-level notification sent by Actito.
///
/// An [ActitoSystemNotification] contains metadata about system events or updates,
/// distinct from user-targeted notifications. These notifications may include
/// additional information in the [extra] map.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoSystemNotification {
  /// Unique identifier of the system notification.
  final String id;

  /// Type of the system notification.
  final String type;

  /// Additional unstructured fields not explicitly modeled.
  final Map<String, String?> extra;

  /// Constructor for [ActitoSystemNotification].
  ActitoSystemNotification({
    required this.id,
    required this.type,
    required this.extra,
  });

  /// Creates an [ActitoSystemNotification] from a JSON map.
  factory ActitoSystemNotification.fromJson(Map<String, dynamic> json) =>
      _$ActitoSystemNotificationFromJson(json);

  /// Converts this [ActitoSystemNotification] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoSystemNotificationToJson(this);
}
