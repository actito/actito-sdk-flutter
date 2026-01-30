import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_user_inbox_item.g.dart';

/// Represents an item in the Actito user inbox.
///
/// An [ActitoUserInboxItem] contains a notification and metadata about its read
/// state within the inbox. Inbox items can optionally have an expiration date.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoUserInboxItem {
  /// Unique identifier of the inbox item.
  final String id;

  /// Notification associated with this inbox item.
  final ActitoNotification notification;

  /// Timestamp indicating when the item was received.
  final DateTime time;

  /// Indicates whether the item has been opened by the user.
  final bool opened;

  /// Optional expiration timestamp of the item.
  final DateTime? expires;

  /// Constructor for [ActitoUserInboxItem].
  ActitoUserInboxItem({
    required this.id,
    required this.notification,
    required this.time,
    required this.opened,
    required this.expires,
  });

  /// Creates an [ActitoUserInboxItem] from a JSON map.
  factory ActitoUserInboxItem.fromJson(Map<String, dynamic> json) =>
      _$ActitoUserInboxItemFromJson(json);

  /// Converts this [ActitoUserInboxItem] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoUserInboxItemToJson(this);
}
