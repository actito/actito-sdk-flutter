import 'package:json_annotation/json_annotation.dart';

part 'actito_system_notification.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoSystemNotification {
  final String id;
  final String type;
  final Map<String, String?> extra;

  ActitoSystemNotification({
    required this.id,
    required this.type,
    required this.extra,
  });

  factory ActitoSystemNotification.fromJson(Map<String, dynamic> json) =>
      _$ActitoSystemNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoSystemNotificationToJson(this);
}
