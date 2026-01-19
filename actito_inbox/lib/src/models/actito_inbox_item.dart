import 'package:json_annotation/json_annotation.dart';
import 'package:actito/actito.dart';

part 'actito_inbox_item.g.dart';

/// Represents an item in the Actito inbox.
///
/// An [ActitoInboxItem] contains a notification and metadata about its delivery
/// and read state within the inbox. Inbox items can optionally have an expiration
/// date.
@JsonSerializable(anyMap: true, explicitToJson: true)
@ActitoIsoDateTimeConverter()
class ActitoInboxItem {
  /// Unique identifier of the inbox item.
  final String id;

  /// [ActitoNotification] associated with this inbox item.
  final ActitoNotification notification;

  /// Timestamp indicating when the item was received.
  final DateTime time;

  /// Indicates whether the item has been opened by the user.
  final bool opened;

  /// Optional expiration timestamp of the item.
  final DateTime? expires;

  /// Constructor for [ActitoInboxItem].
  ActitoInboxItem({
    required this.id,
    required this.notification,
    required this.time,
    required this.opened,
    required this.expires,
  });

  /// Creates an [ActitoInboxItem] from a JSON map.
  factory ActitoInboxItem.fromJson(Map<String, dynamic> json) =>
      _$ActitoInboxItemFromJson(json);

  /// Converts this [ActitoInboxItem] to a JSON map.
  Map<String, dynamic> toJson() => _$ActitoInboxItemToJson(this);
}
