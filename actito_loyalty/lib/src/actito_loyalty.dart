import 'package:flutter/services.dart';
import 'package:actito_loyalty/src/models/actito_pass.dart';

class ActitoLoyalty {
  ActitoLoyalty._();

  static const MethodChannel _channel = MethodChannel(
    'com.actito.loyalty.flutter/actito_loyalty',
    JSONMethodCodec(),
  );

  // Methods
  static Future<ActitoPass> fetchPassBySerial(String serial) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
      'fetchPassBySerial',
      serial,
    );
    return ActitoPass.fromJson(json!);
  }

  static Future<ActitoPass> fetchPassByBarcode(String barcode) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
      'fetchPassByBarcode',
      barcode,
    );
    return ActitoPass.fromJson(json!);
  }

  static Future<void> present({required ActitoPass pass}) async {
    await _channel.invokeMethod('present', pass.toJson());
  }
}
