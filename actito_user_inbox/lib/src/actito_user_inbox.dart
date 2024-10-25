import 'dart:async';

import 'package:flutter/services.dart';
import 'package:actito/actito.dart';
import 'package:actito_user_inbox/src/models/actito_user_inbox_item.dart';
import 'package:actito_user_inbox/src/models/actito_user_inbox_response.dart';

class ActitoUserInbox {
  ActitoUserInbox._();

  // Channels
  static const _channel = MethodChannel(
    'com.actito.inbox.user.flutter/actito_user_inbox',
    JSONMethodCodec(),
  );

  static Future<ActitoUserInboxResponse> parseResponseFromJSON(
    Map<String, dynamic> json,
  ) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'parseResponseFromJSON',
      json,
    );
    return ActitoUserInboxResponse.fromJson(result!);
  }

  static Future<ActitoUserInboxResponse> parseResponseFromString(
    String json,
  ) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'parseResponseFromString',
      json,
    );
    return ActitoUserInboxResponse.fromJson(result!);
  }

  static Future<ActitoNotification> open(
    ActitoUserInboxItem item,
  ) async {
    final result =
        await _channel.invokeMapMethod<String, dynamic>('open', item.toJson());
    return ActitoNotification.fromJson(result!);
  }

  static Future<void> markAsRead(ActitoUserInboxItem item) async {
    await _channel.invokeMethod('markAsRead', item.toJson());
  }

  static Future<void> remove(ActitoUserInboxItem item) async {
    await _channel.invokeMethod('remove', item.toJson());
  }
}
