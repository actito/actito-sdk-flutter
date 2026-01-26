import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/models/actito_do_not_disturb.dart';

part 'actito_device.g.dart';

/// Represents a device registered in Actito.
///
/// An [ActitoDevice] is associated with a physical device and may be optionally
/// linked to a user. It contains timezone information, user-related metadata,
/// and optional configuration such as do-not-disturb settings.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDevice {
  /// Unique identifier of the device.
  final String id;

  /// Optional identifier of the user associated with the device.
  final String? userId;

  /// Optional display name of the associated user.
  final String? userName;

  /// Time zone offset of the device in hours relative to UTC.
  final double timeZoneOffset;

  /// Optional [ActitoDoNotDisturb] configuration for the device.
  final ActitoDoNotDisturb? dnd;

  /// Custom user data associated with the device.
  ///
  /// This map contains key–value pairs representing user attributes or profile
  /// information linked to the device.
  final Map<String, String> userData;

  /// Constructor for [ActitoDevice].
  ActitoDevice({
    required this.id,
    this.userId,
    this.userName,
    required this.timeZoneOffset,
    this.dnd,
    required this.userData,
  });

  /// Creates an [ActitoDevice] from a JSON map.
  factory ActitoDevice.fromJson(Map<String, dynamic> json) =>
      _$ActitoDeviceFromJson(json);

  /// Converts this [ActitoDevice] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoDeviceToJson(this);
}
