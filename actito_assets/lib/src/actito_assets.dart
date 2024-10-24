import 'package:flutter/services.dart';
import 'package:actito_assets/src/models/actito_asset.dart';

class ActitoAssets {
  ActitoAssets._();

  // Channels
  static const _channel = MethodChannel(
    'com.actito.assets.flutter/actito_assets',
    JSONMethodCodec(),
  );

  // Methods
  static Future<List<ActitoAsset>> fetch({required String group}) async {
    final json =
        await _channel.invokeListMethod<Map<String, dynamic>>('fetch', group);
    return json!.map((e) => ActitoAsset.fromJson(e)).toList();
  }
}
