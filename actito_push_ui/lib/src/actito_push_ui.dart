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

  /// Presents a notification to the user.
  ///
  /// This method launches the UI for displaying the provided
  /// [ActitoNotification].
  ///
  /// - notification` The [ActitoNotification] to present.
  static Future<void> presentNotification(
    ActitoNotification notification,
  ) async {
    await _channel.invokeMethod('presentNotification', notification.toJson());
  }

  /// Presents an action associated with a notification.
  ///
  /// This method presents the UI for executing a specific
  /// [ActitoNotificationAction] associated with the provided
  /// [ActitoNotification].
  ///
  /// - `notification`: The [ActitoNotification] to present.
  /// - `action`: The [ActitoNotificationAction] to execute.
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

  /// Called when a notification is about to be presented.
  ///
  /// This method is invoked before the notification is shown to the user.
  ///
  /// It will provide the [ActitoNotification] that will be presented.
  static Stream<ActitoNotification> get onNotificationWillPresent {
    return _getEventStream('notification_will_present').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  /// Called when a notification has been presented.
  ///
  /// This method is triggered when the notification has been shown to the user.
  ///
  /// It will provide the [ActitoNotification] that was presented.
  static Stream<ActitoNotification> get onNotificationPresented {
    return _getEventStream('notification_presented').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  /// Called when the presentation of a notification has finished.
  ///
  /// This method is invoked after the notification UI has been dismissed or the
  /// notification interaction has completed.
  ///
  /// It will provide the [ActitoNotification] that finished presenting.
  static Stream<ActitoNotification> get onNotificationFinishedPresenting {
    return _getEventStream('notification_finished_presenting').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  /// Called when a notification fails to present.
  ///
  /// This method is invoked if there is an error preventing the notification from
  /// being presented.
  ///
  /// It will provide the [ActitoNotification] that failed to present.
  static Stream<ActitoNotification> get onNotificationFailedToPresent {
    return _getEventStream('notification_failed_to_present').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotification.fromJson(json.cast());
    });
  }

  /// Called when a URL within a notification is clicked.
  ///
  /// This method is triggered when the user clicks a URL in the notification.
  ///
  /// It will provide a [ActitoNotificationUrlClickedEvent] containing the
  /// string URL and the [ActitoNotification] containing it.
  static Stream<ActitoNotificationUrlClickedEvent>
      get onNotificationUrlClicked {
    return _getEventStream('notification_url_clicked').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoNotificationUrlClickedEvent.fromJson(json.cast());
    });
  }

  /// Called when an action associated with a notification is about to execute.
  ///
  /// This method is invoked right before the action associated with a notification
  /// is executed.
  ///
  /// It will provide a [ActitoActionWillExecuteEvent] containing the
  /// [ActitoNotificationAction] that will be executed and the
  /// [ActitoNotification] containing it.
  static Stream<ActitoActionWillExecuteEvent> get onActionWillExecute {
    return _getEventStream('action_will_execute').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionWillExecuteEvent.fromJson(json.cast());
    });
  }

  /// Called when an action associated with a notification has been executed.
  ///
  /// This method is triggered after the action associated with the notification
  /// has been successfully executed.
  ///
  /// It will provide a [ActitoActionExecutedEvent] containing the
  /// [ActitoNotificationAction] that was executed and the
  /// [ActitoNotification] containing it.
  static Stream<ActitoActionExecutedEvent> get onActionExecuted {
    return _getEventStream('action_executed').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionExecutedEvent.fromJson(json.cast());
    });
  }

  /// Called when an action associated with a notification is available but has
  /// not been executed by the user.
  ///
  /// This method is triggered after the action associated with the notification
  /// has not been executed, caused by user interaction.
  ///
  /// It will provide a [ActitoActionNotExecutedEvent] containing the
  /// [ActitoNotificationAction] that was not executed and the
  /// [ActitoNotification] containing it.
  static Stream<ActitoActionNotExecutedEvent> get onActionNotExecuted {
    return _getEventStream('action_not_executed').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionNotExecutedEvent.fromJson(json.cast());
    });
  }

  /// Called when an action associated with a notification fails to execute.
  ///
  /// This method is triggered if an error occurs while trying to execute an
  /// action associated with the notification.
  ///
  /// It will provide a [ActitoActionFailedToExecuteEvent] containing the
  /// [ActitoNotificationAction] that was failed to execute and the
  /// [ActitoNotification] containing it. It may also contain the error that
  /// caused the failure.
  static Stream<ActitoActionFailedToExecuteEvent> get onActionFailedToExecute {
    return _getEventStream('action_failed_to_execute').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoActionFailedToExecuteEvent.fromJson(json.cast());
    });
  }

  /// Called when a custom action associated with a notification is received.
  ///
  /// This method is triggered when a custom action associated with the
  /// notification is received, such as a deep link or custom URL scheme.
  ///
  /// It will provide a [ActitoCustomActionReceivedEvent] containing the
  /// [ActitoNotificationAction] that triggered the custom action and the
  /// [ActitoNotification] containing it. It also provides the URL
  /// representing the custom action.
  static Stream<ActitoCustomActionReceivedEvent> get onCustomActionReceived {
    return _getEventStream('custom_action_received').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoCustomActionReceivedEvent.fromJson(json.cast());
    });
  }
}
