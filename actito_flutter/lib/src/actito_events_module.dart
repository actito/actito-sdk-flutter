import 'package:flutter/services.dart';

class ActitoEventsModule {
  final MethodChannel _channel;

  ActitoEventsModule(this._channel);

  Future<void> logCustom(
    String event, {
    Map<String, dynamic>? data,
  }) async {
    await _channel.invokeMethod('logCustom', {
      'event': event,
      'data': data,
    });
  }
}
