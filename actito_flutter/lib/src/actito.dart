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
  static const MethodChannel _channel = MethodChannel('com.actito.flutter/actito', JSONMethodCodec());

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  // Modules
  static final _device = ActitoDeviceModule(_channel);
  static final _events = ActitoEventsModule(_channel);

  static ActitoDeviceModule device() => _device;

  static ActitoEventsModule events() => _events;

  // Methods

  static Future<bool> get isConfigured async {
    return await _channel.invokeMethod('isConfigured');
  }

  static Future<bool> get isReady async {
    return await _channel.invokeMethod('isReady');
  }

  static Future<ActitoApplication?> get application async {
    final json = await _channel.invokeMapMethod<String, dynamic>('getApplication');
    return json != null ? ActitoApplication.fromJson(json) : null;
  }

  static Future<void> launch() async {
    await _channel.invokeMethod('launch');
  }

  static Future<void> unlaunch() async {
    await _channel.invokeMethod('unlaunch');
  }

  static Future<ActitoApplication> fetchApplication() async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetchApplication');
    return ActitoApplication.fromJson(json!);
  }

  static Future<ActitoNotification> fetchNotification(String id) async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetchNotification', id);
    return ActitoNotification.fromJson(json!);
  }

  static Future<ActitoDynamicLink> fetchDynamicLink(String url) async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetchDynamicLink', url);
    return ActitoDynamicLink.fromJson(json!);
  }

  static Future<bool> get canEvaluateDeferredLink async {
    return await _channel.invokeMethod('canEvaluateDeferredLink');
  }

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
      _eventStreams[eventType] = _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  static Stream<ActitoApplication> get onReady {
    return _getEventStream('ready').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoApplication.fromJson(json.cast());
    });
  }

  static Stream<void> get onUnlaunched {
    return _getEventStream('unlaunched');
  }

  static Stream<ActitoDevice> get onDeviceRegistered {
    return _getEventStream('device_registered').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoDevice.fromJson(json.cast());
    });
  }

  static Stream<String> get onUrlOpened {
    return _getEventStream('url_opened').map((result) {
      return result as String;
    });
  }
}
