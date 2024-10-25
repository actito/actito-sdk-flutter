import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_user_inbox_item.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoUserInboxItem {
  final String id;
  final ActitoNotification notification;
  final DateTime time;
  final bool opened;
  final DateTime? expires;

  ActitoUserInboxItem({
    required this.id,
    required this.notification,
    required this.time,
    required this.opened,
    required this.expires,
  });

  factory ActitoUserInboxItem.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserInboxItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoUserInboxItemToJson(this);
}
