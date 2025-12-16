import 'dart:async';

import 'package:flutter/services.dart';
import 'package:actito_flutter/src/models/actito_application.dart';
import 'package:actito_flutter/src/models/actito_device.dart';
import 'package:actito_flutter/src/models/actito_dynamic_link.dart';
import 'package:actito_flutter/src/models/actito_notification.dart';
import 'package:actito_flutter/src/actito_device_module.dart';
import 'package:actito_flutter/src/actito_events_module.dart';

class Actito {
  Actito._();

  // Channels
  static const MethodChannel _channel =
      MethodChannel('com.actito.flutter/actito', JSONMethodCodec());

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  // Modules
  static final _device = ActitoDeviceModule(_channel);
  static final _events = ActitoEventsModule(_channel);

  static ActitoDeviceModule device() => _device;

  static ActitoEventsModule events() => _events;

  // Methods

  /// Indicates whether Actito has been configured.
  ///
  /// Returns `true` if Actito is successfully configured, and `false`
  /// otherwise.
  static Future<bool> get isConfigured async {
    return await _channel.invokeMethod('isConfigured');
  }

  /// Indicates whether Actito is ready.
  ///
  /// Returns `true` once the SDK has completed the initialization process and
  /// is ready for use.
  static Future<bool> get isReady async {
    return await _channel.invokeMethod('isReady');
  }

  /// Provides the current application metadata, if available.
  ///
  /// Returns the [ActitoApplication] object representing the configured
  /// application, or `null` if the application is not yet available.
  static Future<ActitoApplication?> get application async {
    final json =
        await _channel.invokeMapMethod<String, dynamic>('getApplication');
    return json != null ? ActitoApplication.fromJson(json) : null;
  }

  /// Launches the Actito SDK, and all the additional available modules,
  /// preparing them for use.
  static Future<void> launch() async {
    await _channel.invokeMethod('launch');
  }

  /// Unlaunches the Actito SDK.
  ///
  /// This method shuts down the SDK, removing all data, both locally and remotely
  /// in the servers. It destroys all the device's data permanently.
  static Future<void> unlaunch() async {
    await _channel.invokeMethod('unlaunch');
  }

  /// Fetches the application metadata.
  ///
  /// Returns the [ActitoApplication] metadata.
  static Future<ActitoApplication> fetchApplication() async {
    final json =
        await _channel.invokeMapMethod<String, dynamic>('fetchApplication');
    return ActitoApplication.fromJson(json!);
  }

  /// Fetches a [ActitoNotification] by its ID.
  ///
  /// - `id`: The ID of the notification to fetch.
  ///
  /// Returns the [ActitoNotification] object associated with the
  /// provided ID.
  static Future<ActitoNotification> fetchNotification(String id) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
        'fetchNotification', id);
    return ActitoNotification.fromJson(json!);
  }

  /// Fetches a [ActitoDynamicLink] from a URL.
  ///
  /// - `url`: The URL to fetch the dynamic link from.
  ///
  /// Returns the [ActitoDynamicLink] object.
  static Future<ActitoDynamicLink> fetchDynamicLink(String url) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
        'fetchDynamicLink', url);
    return ActitoDynamicLink.fromJson(json!);
  }

  /// Checks if a deferred link exists and can be evaluated.
  ///
  /// Returns `true` if a deferred link can be evaluated, `false` otherwise.
  static Future<bool> get canEvaluateDeferredLink async {
    return await _channel.invokeMethod('canEvaluateDeferredLink');
  }

  /// Evaluates the deferred link. Once the deferred link is evaluated,
  /// Actito will open the resolved deep link.
  ///
  /// Returns `true` if the deferred link was successfully evaluated, `false`
  /// otherwise.
  static Future<bool> evaluateDeferredLink() async {
    return await _channel.invokeMethod('evaluateDeferredLink');
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, const JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  /// Called when the Actito SDK is fully ready and the application metadata
  /// is available.
  ///
  /// This method is invoked after the SDK has been successfully launched and is
  /// available for use.
  ///
  /// It will provide the [ActitoApplication] object containing
  /// the application's metadata.
  static Stream<ActitoApplication> get onReady {
    return _getEventStream('ready').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoApplication.fromJson(json.cast());
    });
  }

  /// Called when the Actito SDK has been unlaunched.
  ///
  /// This method is invoked after the SDK has been shut down (unlaunched) and
  /// is no longer in use.
  static Stream<void> get onUnlaunched {
    return _getEventStream('unlaunched');
  }

  /// Called when the device has been successfully registered with the Actito
  /// platform.
  ///
  /// This method is triggered after the device is initially created, which
  /// happens the first time `launch()` is called.
  /// Once created, the method will not trigger again unless the device is
  /// deleted by calling `unlaunch()` and created again on a new `launch()`.
  ///
  /// It will provide the registered [ActitoDevice] instance representing
  /// the device's registration details.
  static Stream<ActitoDevice> get onDeviceRegistered {
    return _getEventStream('device_registered').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoDevice.fromJson(json.cast());
    });
  }

  /// Called when the device opens a URL.
  ///
  /// This method is invoked when the device opens a URL.
  ///
  /// It will provide the opened URL.
  static Stream<String> get onUrlOpened {
    return _getEventStream('url_opened').map((result) {
      return result as String;
    });
  }
}
