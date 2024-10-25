import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:actito/actito.dart';
import 'package:actito_push/actito_push.dart';

class ActitoPush {
  ActitoPush._();

  static const MethodChannel _channel = MethodChannel(
    'com.actito.push.flutter/actito_push',
    JSONMethodCodec(),
  );

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  static Future<void> setAuthorizationOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setAuthorizationOptions', options);
    }
  }

  static Future<void> setCategoryOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setCategoryOptions', options);
    }
  }

  static Future<void> setPresentationOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setPresentationOptions', options);
    }
  }

  static Future<bool> get hasRemoteNotificationsEnabled async {
    return await _channel.invokeMethod('hasRemoteNotificationsEnabled');
  }

  static Future<ActitoTransport?> get transport async {
    final json = await _channel.invokeMethod('getTransport');
    return json != null ? ActitoTransport.fromJson(json) : null;
  }

  static Future<ActitoPushSubscription?> get subscription async {
    final json = await _channel.invokeMethod('getSubscription');
    return json != null ? ActitoPushSubscription.fromJson(json) : null;
  }

  static Future<bool> get allowedUI async {
    return await _channel.invokeMethod('allowedUI');
  }

  static Future<void> enableRemoteNotifications() async {
    await _channel.invokeMapMethod('enableRemoteNotifications');
  }

  static Future<void> disableRemoteNotifications() async {
    await _channel.invokeMapMethod('disableRemoteNotifications');
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.push.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  static Stream<ActitoNotificationReceivedEvent>
      get onNotificationInfoReceived {
    return _getEventStream('notification_info_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationReceivedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoSystemNotification> get onSystemNotificationReceived {
    return _getEventStream('system_notification_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoSystemNotification.fromJson(json.cast());
    });
  }

  static Stream<Map<String, dynamic>> get onUnknownNotificationReceived {
    return _getEventStream('unknown_notification_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return json.cast();
    });
  }

  static Stream<ActitoNotification> get onNotificationOpened {
    return _getEventStream('notification_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<Map<String, dynamic>> get onUnknownNotificationOpened {
    return _getEventStream('unknown_notification_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return json.cast();
    });
  }

  static Stream<ActitoNotificationActionOpenedEvent>
      get onNotificationActionOpened {
    return _getEventStream('notification_action_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationActionOpenedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoUnknownNotificationActionOpenedEvent>
      get onUnknownNotificationActionOpened {
    return _getEventStream('unknown_notification_action_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoUnknownNotificationActionOpenedEvent.fromJson(
        json.cast(),
      );
    });
  }

  static Stream<bool> get onNotificationSettingsChanged {
    return _getEventStream('notification_settings_changed').map((result) {
      return result as bool;
    });
  }

  static Stream<ActitoPushSubscription?> get onSubscriptionChanged {
    return _getEventStream('subscription_changed').map((result) {
      final Map<dynamic, dynamic>? json = result;
      return json != null
          ? ActitoPushSubscription.fromJson(json.cast())
          : null;
    });
  }

  static Stream<ActitoNotification?> get onShouldOpenNotificationSettings {
    return _getEventStream('should_open_notification_settings').map((result) {
      if (result == null) return null;

      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<String> get onFailedToRegisterForRemoteNotifications {
    return _getEventStream('failed_to_register_for_remote_notifications')
        .map((result) {
      return result as String;
    });
  }
}
