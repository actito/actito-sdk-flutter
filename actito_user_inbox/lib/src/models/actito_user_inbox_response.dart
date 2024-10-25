import 'package:json_annotation/json_annotation.dart';
import 'actito_user_inbox_item.dart';

part 'actito_user_inbox_response.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUserInboxResponse {
  final int count;
  final int unread;
  final List<ActitoUserInboxItem> items;

  ActitoUserInboxResponse({
    required this.count,
    required this.unread,
    required this.items,
  });

  factory ActitoUserInboxResponse.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserInboxResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActitoUserInboxResponseToJson(this);
}
