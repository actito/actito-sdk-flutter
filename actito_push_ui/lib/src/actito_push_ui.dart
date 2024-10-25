import 'dart:async';

import 'package:flutter/services.dart';
import 'package:actito/actito.dart';
import 'package:actito_push_ui/src/events/actito_action_executed_event.dart';
import 'package:actito_push_ui/src/events/actito_action_failed_to_execute_event.dart';
import 'package:actito_push_ui/src/events/actito_action_not_executed_event.dart';
import 'package:actito_push_ui/src/events/actito_action_will_execute_event.dart';
import 'package:actito_push_ui/src/events/actito_custom_action_received_event.dart';
import 'package:actito_push_ui/src/events/actito_notification_url_clicked_event.dart';

class ActitoPushUI {
  ActitoPushUI._();

  static const MethodChannel _channel = MethodChannel(
    'com.actito.push.ui.flutter/actito_push_ui',
    JSONMethodCodec(),
  );

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  static Future<void> presentNotification(
    ActitoNotification notification,
  ) async {
    await _channel.invokeMethod('presentNotification', notification.toJson());
  }

  static Future<void> presentAction(
    ActitoNotification notification,
    ActitoNotificationAction action,
  ) async {
    await _channel.invokeMethod('presentAction', {
      'notification': notification.toJson(),
      'action': action.toJson(),
    });
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.push.ui.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  static Stream<ActitoNotification> get onNotificationWillPresent {
    return _getEventStream('notification_will_present').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<ActitoNotification> get onNotificationPresented {
    return _getEventStream('notification_presented').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<ActitoNotification> get onNotificationFinishedPresenting {
    return _getEventStream('notification_finished_presenting').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<ActitoNotification> get onNotificationFailedToPresent {
    return _getEventStream('notification_failed_to_present').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  static Stream<ActitoNotificationUrlClickedEvent>
      get onNotificationUrlClicked {
    return _getEventStream('notification_url_clicked').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationUrlClickedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionWillExecuteEvent> get onActionWillExecute {
    return _getEventStream('action_will_execute').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionWillExecuteEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionExecutedEvent> get onActionExecuted {
    return _getEventStream('action_executed').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionExecutedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionNotExecutedEvent> get onActionNotExecuted {
    return _getEventStream('action_not_executed').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionNotExecutedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionFailedToExecuteEvent>
      get onActionFailedToExecute {
    return _getEventStream('action_failed_to_execute').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionFailedToExecuteEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoCustomActionReceivedEvent>
      get onCustomActionReceived {
    return _getEventStream('custom_action_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoCustomActionReceivedEvent.fromJson(json.cast());
    });
  }
}
