import 'dart:async';

import 'package:flutter/services.dart';
import 'package:actito_in_app_messaging/src/events/actito_action_executed_event.dart';
import 'package:actito_in_app_messaging/src/events/actito_action_failed_to_execute_event.dart';
import 'package:actito_in_app_messaging/src/models/actito_in_app_message.dart';

class ActitoInAppMessaging {
  ActitoInAppMessaging._();

  // Channels
  static const _channel = MethodChannel(
    'com.actito.iam.flutter/actito_in_app_messaging',
    JSONMethodCodec(),
  );

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  static Future<bool> get hasMessagesSuppressed async {
    return await _channel.invokeMethod('hasMessagesSuppressed');
  }

  static Future<void> setMessagesSuppressed(
    bool suppressed, {
    bool? evaluateContext,
  }) async {
    await _channel.invokeMethod('setMessagesSuppressed', {
      "suppressed": suppressed,
      "evaluateContext": evaluateContext,
    });
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.iam.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, const JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  static Stream<ActitoInAppMessage> get onMessagePresented {
    return _getEventStream('message_presented').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoInAppMessage.fromJson(json.cast());
    });
  }

  static Stream<ActitoInAppMessage> get onMessageFinishedPresenting {
    return _getEventStream('message_finished_presenting').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoInAppMessage.fromJson(json.cast());
    });
  }

  static Stream<ActitoInAppMessage> get onMessageFailedToPresent {
    return _getEventStream('message_failed_to_present').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoInAppMessage.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionExecutedEvent> get onActionExecuted {
    return _getEventStream('action_executed').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionExecutedEvent.fromJson(json.cast());
    });
  }

  static Stream<ActitoActionFailedToExecuteEvent>
      get onActionFailedToExecute {
    return _getEventStream('action_failed_to_execute').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionFailedToExecuteEvent.fromJson(json.cast());
    });
  }
}
