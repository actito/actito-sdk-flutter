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

  /// Defines the authorization options used when requesting push notification
  /// permissions.
  ///
  /// **Note**: This method is only supported on iOS.
  ///
  /// - `options`: The authorization options to be set.
  static Future<void> setAuthorizationOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setAuthorizationOptions', options);
    }
  }

  /// Defines the notification category options for custom notification actions.
  ///
  /// **Note**: This method is only supported on iOS.
  ///
  /// - `options`: The category options to be set
  static Future<void> setCategoryOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setCategoryOptions', options);
    }
  }

  /// Defines the presentation options for displaying notifications while the app
  /// is in the foreground.
  ///
  /// **Note**: This method is only supported on iOS.
  ///
  /// - `options`: The presentation options to be set.
  static Future<void> setPresentationOptions(List<String> options) async {
    if (Platform.isIOS) {
      await _channel.invokeMapMethod('setPresentationOptions', options);
    }
  }

  /// Indicates whether remote notifications are enabled.
  ///
  /// Returns `true` if remote notifications are enabled for the application, and
  /// `false` otherwise.
  static Future<bool> get hasRemoteNotificationsEnabled async {
    return await _channel.invokeMethod('hasRemoteNotificationsEnabled');
  }

  /// Provides the current push transport information.
  ///
  /// Returns the [ActitoTransport] assigned to the device.
  static Future<ActitoTransport?> get transport async {
    final json = await _channel.invokeMethod('getTransport');
    return json != null ? ActitoTransport.fromJson(json) : null;
  }

  /// Provides the current push subscription token.
  ///
  /// Returns the [ActitoPushSubscription] object containing the
  /// device's current push subscription token, or `null` if no token is available.
  static Future<ActitoPushSubscription?> get subscription async {
    final json = await _channel.invokeMethod('getSubscription');
    return json != null ? ActitoPushSubscription.fromJson(json) : null;
  }

  /// Indicates whether the device is capable of receiving remote notifications.
  ///
  /// This function returns `true` if the user has granted permission to receive
  /// push notifications and the device has successfully obtained a push token
  /// from the notification service. It reflects whether the app can present
  /// notifications as allowed by the system and user settings.
  ///
  /// Return `true` if the device can receive remote notifications, `false`
  /// otherwise.
  static Future<bool> get allowedUI async {
    return await _channel.invokeMethod('allowedUI');
  }

  /// Enables remote notifications.
  ///
  /// This function enables remote notifications for the application,
  /// allowing push notifications to be received.
  ///
  /// **Note**: Starting with Android 13 (API level 33), this function requires
  /// the developer to explicitly request the `POST_NOTIFICATIONS` permission from
  /// the user.
  static Future<void> enableRemoteNotifications() async {
    await _channel.invokeMapMethod('enableRemoteNotifications');
  }

  /// Disables remote notifications.
  ///
  /// This function disables remote notifications for the application, preventing
  /// push notifications from being received.
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

  /// Called when a push notification is received.
  ///
  /// It will provide a [ActitoNotificationReceivedEvent] containing the
  /// [ActitoNotification] received and the
  /// [ActitoNotificationDeliveryMechanism] used for its delivery.
  static Stream<ActitoNotificationReceivedEvent>
      get onNotificationInfoReceived {
    return _getEventStream('notification_info_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationReceivedEvent.fromJson(json.cast());
    });
  }

  /// Called when a custom system notification is received.
  ///
  /// It will provide the [ActitoSystemNotification] received.
  static Stream<ActitoSystemNotification> get onSystemNotificationReceived {
    return _getEventStream('system_notification_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoSystemNotification.fromJson(json.cast());
    });
  }

  /// Called when an unknown notification is received.
  ///
  /// It will provide the unknown notification received.
  static Stream<Map<String, dynamic>> get onUnknownNotificationReceived {
    return _getEventStream('unknown_notification_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return json.cast();
    });
  }

  /// Called when a push notification is opened by the user.
  ///
  /// It will provide the [ActitoNotification] that was opened.
  static Stream<ActitoNotification> get onNotificationOpened {
    return _getEventStream('notification_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  /// Called when an unknown push notification is opened by the user.
  ///
  /// It will provide the unknown notification that was opened.
  static Stream<Map<String, dynamic>> get onUnknownNotificationOpened {
    return _getEventStream('unknown_notification_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return json.cast();
    });
  }

  /// Called when a push notification action is opened by the user.
  ///
  /// It will provide a [ActitoNotificationActionOpenedEvent] containing the
  /// [ActitoNotificationAction] opened by the user and the
  /// [ActitoNotification] containing it.
  static Stream<ActitoNotificationActionOpenedEvent>
      get onNotificationActionOpened {
    return _getEventStream('notification_action_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationActionOpenedEvent.fromJson(json.cast());
    });
  }

  /// Called when an unknown push notification action is opened by the user.
  ///
  /// It will provide a [ActitoUnknownNotificationActionOpenedEvent]
  /// containing the action opened by the user and the unknown notification
  /// containing it. It will also provide a response text, if it exists.
  static Stream<ActitoUnknownNotificationActionOpenedEvent>
      get onUnknownNotificationActionOpened {
    return _getEventStream('unknown_notification_action_opened').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoUnknownNotificationActionOpenedEvent.fromJson(
        json.cast(),
      );
    });
  }

  /// Called when the notification settings are changed.
  ///
  /// It will provide a boolean indicating whether the app is permitted to
  /// display notifications. `true` if notifications are allowed, `false` if they
  /// are restricted by the user.
  static Stream<bool> get onNotificationSettingsChanged {
    return _getEventStream('notification_settings_changed').map((result) {
      return result as bool;
    });
  }

  /// Called when the device's push subscription changes.
  ///
  /// It will provide the updated [ActitoPushSubscription], or `null` if the
  /// subscription token is unavailable.
  static Stream<ActitoPushSubscription?> get onSubscriptionChanged {
    return _getEventStream('subscription_changed').map((result) {
      final Map<dynamic, dynamic>? json = result;
      return json != null
          ? ActitoPushSubscription.fromJson(json.cast())
          : null;
    });
  }

  /// Called when a notification prompts the app to open its settings screen.
  ///
  /// It will provide the [ActitoNotification] that prompted the app to open
  /// its settings screen.
  static Stream<ActitoNotification?> get onShouldOpenNotificationSettings {
    return _getEventStream('should_open_notification_settings').map((result) {
      if (result == null) return null;

      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  ///  Called when the app encounters an error during the registration process for
  ///  push notifications.
  ///
  /// It will provide the error that caused the registration to fail.
  static Stream<String> get onFailedToRegisterForRemoteNotifications {
    return _getEventStream('failed_to_register_for_remote_notifications')
        .map((result) {
      return result as String;
    });
  }
}
