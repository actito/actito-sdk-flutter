import 'package:flutter/services.dart';
import 'package:actito_scannables/src/models/actito_scannable.dart';

class ActitoScannables {
  ActitoScannables._();

  static const MethodChannel _channel = MethodChannel(
    'com.actito.scannables.flutter/actito_scannables',
    JSONMethodCodec(),
  );

  // Events
  static final Map<String, EventChannel> _eventChannels = {};
  static final Map<String, Stream<dynamic>> _eventStreams = {};

  // Methods
  static Future<bool> get canStartNfcScannableSession async {
    return await _channel.invokeMethod('canStartNfcScannableSession');
  }

  static Future<void> startScannableSession() async {
    await _channel.invokeMethod('startScannableSession');
  }

  static Future<void> startNfcScannableSession() async {
    await _channel.invokeMethod('startNfcScannableSession');
  }

  static Future<void> startQrCodeScannableSession() async {
    await _channel.invokeMethod('startQrCodeScannableSession');
  }

  static Future<ActitoScannable> fetch({required String tag}) async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetch', tag);
    return ActitoScannable.fromJson(json!);
  }

  // Events
  static Stream<dynamic> _getEventStream(String eventType) {
    if (_eventChannels[eventType] == null) {
      final name = 'com.actito.scannables.flutter/events/$eventType';
      _eventChannels[eventType] = EventChannel(name, const JSONMethodCodec());
    }

    if (_eventStreams[eventType] == null) {
      _eventStreams[eventType] =
          _eventChannels[eventType]!.receiveBroadcastStream();
    }

    return _eventStreams[eventType]!;
  }

  static Stream<ActitoScannable> get onScannableDetected {
    return _getEventStream('scannable_detected').map((result) {
      final Map<dynamic, dynamic> json = result;
      return ActitoScannable.fromJson(json.cast());
    });
  }

  static Stream<String?> get onScannableSessionFailed {
    return _getEventStream('scannable_session_failed').map((result) {
      return result;
    });
  }
}
