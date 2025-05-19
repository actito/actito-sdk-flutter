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

  /// Parses a JSON map to produce a [ActitoUserInboxResponse].
  ///
  /// This method takes a raw JSON map and converts it into a structured
  /// [ActitoUserInboxResponse].
  ///
  /// - `json`: The JSON Map representing the user inbox response.
  ///
  /// Returns a [ActitoUserInboxResponse] object parsed from the provided
  /// JSON map.
  static Future<ActitoUserInboxResponse> parseResponseFromJSON(
    Map<String, dynamic> json,
  ) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'parseResponseFromJSON',
      json,
    );
    return ActitoUserInboxResponse.fromJson(result!);
  }

  /// Parses a JSON string to produce a [ActitoUserInboxResponse].
  ///
  /// This method takes a raw JSON string and converts it into a structured
  /// [ActitoUserInboxResponse].
  ///
  /// - `json`: The JSON string representing the user inbox response.
  ///
  /// Returns a [ActitoUserInboxResponse] object parsed from the provided
  /// JSON string.
  static Future<ActitoUserInboxResponse> parseResponseFromString(
    String json,
  ) async {
    final result = await _channel.invokeMapMethod<String, dynamic>(
      'parseResponseFromString',
      json,
    );
    return ActitoUserInboxResponse.fromJson(result!);
  }

  /// Opens an inbox item and retrieves its associated notification.
  ///
  /// This function opens the provided [ActitoUserInboxItem] and returns the
  /// associated [ActitoNotification].
  /// This operation marks the item as read.
  ///
  /// - `item`: The [ActitoUserInboxItem] to be opened.
  ///
  /// Returns the [ActitoNotification] associated with the opened inbox
  /// item.
  static Future<ActitoNotification> open(
    ActitoUserInboxItem item,
  ) async {
    final result =
        await _channel.invokeMapMethod<String, dynamic>('open', item.toJson());
    return ActitoNotification.fromJson(result!);
  }

  /// Marks an inbox item as read.
  ///
  /// This function updates the status of the provided [ActitoUserInboxItem]
  /// to read.
  ///
  /// - `item`: The [ActitoUserInboxItem] to mark as read.
  static Future<void> markAsRead(ActitoUserInboxItem item) async {
    await _channel.invokeMethod('markAsRead', item.toJson());
  }

  /// Removes an inbox item from the user's inbox.
  ///
  /// This function deletes the provided [ActitoUserInboxItem] from the
  /// user's inbox.
  ///
  /// - `item`: The [ActitoUserInboxItem] to be removed.
  static Future<void> remove(ActitoUserInboxItem item) async {
    await _channel.invokeMethod('remove', item.toJson());
  }
}
