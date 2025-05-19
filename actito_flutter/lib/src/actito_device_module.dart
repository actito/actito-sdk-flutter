import 'package:flutter/services.dart';
import 'package:actito_flutter/src/models/actito_device.dart';
import 'package:actito_flutter/src/models/actito_do_not_disturb.dart';

class ActitoDeviceModule {
  final MethodChannel _channel;

  ActitoDeviceModule(this._channel);

  /// Returns the current [ActitoDevice] information.
  Future<ActitoDevice?> get currentDevice async {
    final json = await _channel.invokeMapMethod<String, dynamic>('getCurrentDevice');
    return json != null ? ActitoDevice.fromJson(json) : null;
  }

  /// Returns the preferred language of the current device for notifications and
  /// messages.
  Future<String?> get preferredLanguage async {
    return _channel.invokeMethod<String>('getPreferredLanguage');
  }

  /// Updates the preferred language setting for the device.
  ///
  /// - `language`: The preferred language code.
  Future<void> updatePreferredLanguage(String? language) async {
    await _channel.invokeMethod('updatePreferredLanguage', language);
  }

  /// Registers a user for the device.
  ///
  /// To register the device anonymously, set both `userId` and `userName` to `null`.
  ///
  /// - `userId`: Optional user identifier.
  /// - `userName: Optional username.
  @Deprecated(
    'Use updateUser() instead.',
  )
  Future<void> register({
    required String? userId,
    required String? userName,
  }) async {
    await _channel.invokeMethod('register', {'userId': userId, 'userName': userName});
  }

  /// Updates the user information for the device.
  ///
  /// To register the device anonymously, set both `userId` and `userName` to `null`.
  ///
  /// - `userId`: Optional user identifier.
  /// - `userName`: Optional username.
  Future<void> updateUser({
    required String? userId,
    required String? userName,
  }) async {
    await _channel.invokeMethod('updateUser', {'userId': userId, 'userName': userName});
  }

  /// Fetches the tags associated with the device.
  ///
  /// Returns a list of tags currently associated with the device.
  Future<List<String>> fetchTags() async {
    final result = await _channel.invokeListMethod<String>('fetchTags');
    return result!;
  }

  /// Adds a single tag to the device.
  ///
  /// - `tag`: The tag to add.
  Future<void> addTag(String tag) async {
    await _channel.invokeMethod('addTag', tag);
  }

  /// Adds multiple tags to the device.
  ///
  /// - `tags`: A list of tags to add.
  Future<void> addTags(List<String> tags) async {
    await _channel.invokeMethod('addTags', tags);
  }

  /// Removes a specific tag from the device.
  ///
  /// - `tag`: The tag to remove.
  Future<void> removeTag(String tag) async {
    await _channel.invokeMethod('removeTag', tag);
  }

  /// Removes multiple tags from the device.
  ///
  /// - `tags`: A list of tags to remove.
  Future<void> removeTags(List<String> tags) async {
    await _channel.invokeMethod('removeTags', tags);
  }

  /// Clears all tags from the device.
  Future<void> clearTags() async {
    await _channel.invokeMethod('clearTags');
  }

  /// Fetches the "Do Not Disturb" (DND) settings for the device.
  ///
  /// Returns the current [ActitoDoNotDisturb] settings, or `null` if
  /// none are set.
  Future<ActitoDoNotDisturb?> fetchDoNotDisturb() async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetchDoNotDisturb');
    return json != null ? ActitoDoNotDisturb.fromJson(json) : null;
  }

  /// Updates the "Do Not Disturb" (DND) settings for the device.
  ///
  /// - `dnd`: The new [ActitoDoNotDisturb] settings to apply.
  Future<void> updateDoNotDisturb(ActitoDoNotDisturb dnd) async {
    await _channel.invokeMethod('updateDoNotDisturb', dnd.toJson());
  }

  /// Clears the "Do Not Disturb" (DND) settings for the device.
  Future<void> clearDoNotDisturb() async {
    await _channel.invokeMethod('clearDoNotDisturb');
  }

  /// Fetches the user data associated with the device.
  ///
  /// Returns the current user data.
  Future<Map<String, String>> fetchUserData() async {
    return (await _channel.invokeMapMethod<String, String>('fetchUserData'))!;
  }

  /// Updates the custom user data associated with the device.
  ///
  /// - `userData`: The updated user data to associate with the device.
  Future<void> updateUserData(Map<String, String> userData) async {
    await _channel.invokeMethod('updateUserData', userData);
  }
}
