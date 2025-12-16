import 'package:flutter/services.dart';
import 'package:actito_loyalty/src/models/actito_pass.dart';

class ActitoLoyalty {
  ActitoLoyalty._();

  static const MethodChannel _channel = MethodChannel(
    'com.actito.loyalty.flutter/actito_loyalty',
    JSONMethodCodec(),
  );

  // Methods

  /// Fetches a pass by its serial number.
  ///
  /// - `serial`: The serial number of the pass to be fetched.
  ///
  /// Returns the fetched [ActitoPass] corresponding to the given serial
  /// number.
  static Future<ActitoPass> fetchPassBySerial(String serial) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
      'fetchPassBySerial',
      serial,
    );
    return ActitoPass.fromJson(json!);
  }

  /// Fetches a pass by its barcode.
  ///
  /// - `barcode`: The barcode of the pass to be fetched.
  ///
  /// Returns the fetched [ActitoPass] corresponding to the given
  /// barcode.
  static Future<ActitoPass> fetchPassByBarcode(String barcode) async {
    final json = await _channel.invokeMapMethod<String, dynamic>(
      'fetchPassByBarcode',
      barcode,
    );
    return ActitoPass.fromJson(json!);
  }

  /// Presents a pass to the user.
  ///
  ///- `pass`: The [ActitoPass] to be presented to the user.
  static Future<void> present({required ActitoPass pass}) async {
    await _channel.invokeMethod('present', pass.toJson());
  }
}
