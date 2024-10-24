import 'package:flutter/services.dart';
import 'package:actito_flutter/src/models/actito_device.dart';
import 'package:actito_flutter/src/models/actito_do_not_disturb.dart';

class ActitoDeviceModule {
  final MethodChannel _channel;

  ActitoDeviceModule(this._channel);

  Future<ActitoDevice?> get currentDevice async {
    final json = await _channel.invokeMapMethod<String, dynamic>('getCurrentDevice');
    return json != null ? ActitoDevice.fromJson(json) : null;
  }

  Future<String?> get preferredLanguage async {
    return _channel.invokeMethod<String>('getPreferredLanguage');
  }

  Future<void> updatePreferredLanguage(String? language) async {
    await _channel.invokeMethod('updatePreferredLanguage', language);
  }

  @Deprecated(
    'Use updateUser() instead.',
  )
  Future<void> register({
    required String? userId,
    required String? userName,
  }) async {
    await _channel.invokeMethod('register', {'userId': userId, 'userName': userName});
  }

  Future<void> updateUser({
    required String? userId,
    required String? userName,
  }) async {
    await _channel.invokeMethod('updateUser', {'userId': userId, 'userName': userName});
  }

  Future<List<String>> fetchTags() async {
    final result = await _channel.invokeListMethod<String>('fetchTags');
    return result!;
  }

  Future<void> addTag(String tag) async {
    await _channel.invokeMethod('addTag', tag);
  }

  Future<void> addTags(List<String> tags) async {
    await _channel.invokeMethod('addTags', tags);
  }

  Future<void> removeTag(String tag) async {
    await _channel.invokeMethod('removeTag', tag);
  }

  Future<void> removeTags(List<String> tags) async {
    await _channel.invokeMethod('removeTags', tags);
  }

  Future<void> clearTags() async {
    await _channel.invokeMethod('clearTags');
  }

  Future<ActitoDoNotDisturb?> fetchDoNotDisturb() async {
    final json = await _channel.invokeMapMethod<String, dynamic>('fetchDoNotDisturb');
    return json != null ? ActitoDoNotDisturb.fromJson(json) : null;
  }

  Future<void> updateDoNotDisturb(ActitoDoNotDisturb dnd) async {
    await _channel.invokeMethod('updateDoNotDisturb', dnd.toJson());
  }

  Future<void> clearDoNotDisturb() async {
    await _channel.invokeMethod('clearDoNotDisturb');
  }

  Future<Map<String, String>> fetchUserData() async {
    return (await _channel.invokeMapMethod<String, String>('fetchUserData'))!;
  }

  Future<void> updateUserData(Map<String, String> userData) async {
    await _channel.invokeMethod('updateUserData', userData);
  }
}
