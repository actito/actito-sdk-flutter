import 'package:flutter/services.dart';

class ActitoEventsModule {
  final MethodChannel _channel;

  ActitoEventsModule(this._channel);

  /// Logs in Actito a custom event in the application.
  ///
  /// This function allows logging, in Actito, of application-specific events,
  /// optionally associating structured data for more detailed event tracking and
  /// analysis.
  ///
  /// - `event`: The name of the custom event to log.
  /// - `data`: Optional structured event data for further details.
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
