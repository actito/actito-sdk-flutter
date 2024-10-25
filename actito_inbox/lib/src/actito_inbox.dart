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

  static Future<List<ActitoInboxItem>> get items async {
    final json =
        await _channel.invokeListMethod<Map<String, dynamic>>('getItems');
    return json!.map((e) => ActitoInboxItem.fromJson(e)).toList();
  }

  static Future<int> get badge async {
    return await _channel.invokeMethod('getBadge');
  }

  static Future<void> refresh() async {
    await _channel.invokeMethod('refresh');
  }

  static Future<ActitoNotification> open(ActitoInboxItem item) async {
    final json =
        await _channel.invokeMapMethod<String, dynamic>('open', item.toJson());
    return ActitoNotification.fromJson(json!);
  }

  static Future<void> markAsRead(ActitoInboxItem item) async {
    await _channel.invokeMethod('markAsRead', item.toJson());
  }

  static Future<void> markAllAsRead() async {
    await _channel.invokeMethod('markAllAsRead');
  }

  static Future<void> remove(ActitoInboxItem item) async {
    await _channel.invokeMethod('remove', item.toJson());
  }

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

  static Stream<List<ActitoInboxItem>> get onInboxUpdated {
    return _getEventStream('inbox_updated').map((result) {
      final List<dynamic> items = result;

      return items.map((item) {
        final Map json = item;
        return ActitoInboxItem.fromJson(json.cast());
      }).toList();
    });
  }

  static Stream<int> get onBadgeUpdated {
    return _getEventStream('badge_updated').map((result) {
      return result as int;
    });
  }
}
