import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_inbox_item.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoInboxItem {
  final String id;
  final ActitoNotification notification;
  final DateTime time;
  final bool opened;
  final DateTime? expires;

  ActitoInboxItem({
    required this.id,
    required this.notification,
    required this.time,
    required this.opened,
    required this.expires,
  });

  factory ActitoInboxItem.fromJson(Map<String, dynamic> json) =>
      _$ActitoInboxItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoInboxItemToJson(this);
}
