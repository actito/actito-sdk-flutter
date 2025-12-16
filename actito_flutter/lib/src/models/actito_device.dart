import 'package:json_annotation/json_annotation.dart';
import 'package:actito_flutter/src/models/actito_do_not_disturb.dart';

part 'actito_device.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoDevice {
  final String id;
  final String? userId;
  final String? userName;
  final double timeZoneOffset;
  final ActitoDoNotDisturb? dnd;
  final Map<String, String> userData;

  ActitoDevice({
    required this.id,
    this.userId,
    this.userName,
    required this.timeZoneOffset,
    this.dnd,
    required this.userData,
  });

  factory ActitoDevice.fromJson(Map<String, dynamic> json) =>
      _$ActitoDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoDeviceToJson(this);
}
