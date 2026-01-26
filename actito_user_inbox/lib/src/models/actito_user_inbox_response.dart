import 'package:json_annotation/json_annotation.dart';
import 'actito_user_inbox_item.dart';

part 'actito_user_inbox_response.g.dart';

/// Represents the response returned when fetching a user's inbox.
///
/// An [ActitoUserInboxResponse] contains the total number of inbox items, the
/// number of unread items, and the list of items themselves.
@JsonSerializable(anyMap: true, explicitToJson: true)
class ActitoUserInboxResponse {
  /// Total number of items in the user's inbox.
  final int count;

  /// Number of unread items in the user's inbox.
  final int unread;

  /// List of inbox items for the user.
  final List<ActitoUserInboxItem> items;

  /// Constructor for [ActitoUserInboxResponse].
  ActitoUserInboxResponse({
    required this.count,
    required this.unread,
    required this.items,
  });

  /// Creates an [ActitoUserInboxResponse] from a JSON map.
  factory ActitoUserInboxResponse.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserInboxResponseFromJson(json);

  /// Converts this [ActitoUserInboxResponse] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoUserInboxResponseToJson(this);
}
