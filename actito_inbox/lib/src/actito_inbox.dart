import 'dart:async';

import 'package:flutter/services.dart';
import 'package:actito/actito.dart';
import 'package:actito_inbox/src/models/actito_inbox_item.dart';

class ActitoInbox {
  ActitoInbox._();

  // Channels
  static const _channel = MethodChannel(
    'com.actito.inbox.flutter/actito_inbox',
    JSONMethodCodec(),
  );

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  /// Returns a list of all [ActitoInboxItem], sorted by the timestamp.
  static Future<List<ActitoInboxItem>> get items async {
    final json =
        await _channel.invokeListMethod<Map<String, dynamic>>('getItems');
    return json!.map((e) => ActitoInboxItem.fromJson(e)).toList();
  }

  /// Returns The current badge count, representing the number of unread inbox
  /// items.
  static Future<int> get badge async {
    return await _channel.invokeMethod('getBadge');
  }

  /// Refreshes the inbox data, ensuring the items and badge count reflect the
  /// latest server state.
  static Future<void> refresh() async {
    await _channel.invokeMethod('refresh');
  }

  /// Opens a specified inbox item, marking it as read and returning the
  /// associated notification.
  ///
  /// - `item`: The [ActitoInboxItem] to open.
  ///
  /// Returns the [ActitoNotification] associated with the inbox item.
  static Future<ActitoNotification> open(ActitoInboxItem item) async {
    final json =
        await _channel.invokeMapMethod<String, dynamic>('open', item.toJson());
    return ActitoNotification.fromJson(json!);
  }

  /// Marks the specified inbox item as read.
  ///
  /// - `item`: The [ActitoInboxItem] to mark as read.
  static Future<void> markAsRead(ActitoInboxItem item) async {
    await _channel.invokeMethod('markAsRead', item.toJson());
  }

  /// Marks all inbox items as read.
  static Future<void> markAllAsRead() async {
    await _channel.invokeMethod('markAllAsRead');
  }

  /// Permanently removes the specified inbox item from the inbox.
  ///
  /// - `item`: The [ActitoInboxItem] to remove.
  static Future<void> remove(ActitoInboxItem item) async {
    await _channel.invokeMethod('remove', item.toJson());
  }

  /// Clears all inbox items, permanently deleting them from the inbox.
  static Future<void> clear() async {
    await _channel.invokeMethod('clear');
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.inbox.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  /// Called when the inbox is successfully updated.
  ///
  /// It will provide an updated list of [ActitoInboxItem].
  static Stream<List<ActitoInboxItem>> get onInboxUpdated {
    return _getEventStream('inbox_updated').map((result) {
      final List<dynamic> items = result;

      return items.map((item) {
        final Map json = item;
        return ActitoInboxItem.fromJson(json.cast());
      }).toList();
    });
  }

  /// Called when the unread message count badge is updated.
  ///
  /// It will provide an updated badge count, representing current the number of
  /// unread inbox items.
  static Stream<int> get onBadgeUpdated {
    return _getEventStream('badge_updated').map((result) {
      return result as int;
    });
  }
}
