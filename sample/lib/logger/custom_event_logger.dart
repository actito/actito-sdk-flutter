import 'dart:convert';

import 'package:actito/actito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';

void logCustomEvent(String event, Map<String, dynamic>? data) async {
  final device = await Actito.device().currentDevice;
  final sharedPreferences = await SharedPreferences.getInstance();
  final applicationKey = sharedPreferences.getString('applicationKey');
  final applicationSecret = sharedPreferences.getString('applicationSecret');

  if (device == null || applicationKey == null || applicationSecret == null) {
    return;
  }

  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encodedKeyAndSecret =
      stringToBase64.encode('$applicationKey:$applicationSecret');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ' + encodedKeyAndSecret
  };

  var request =
      http.Request('POST', Uri.parse('https://push.notifica.re/event'));

  request.body = json.encode({
    "type": "re.notifica.event.custom.BackgroundEvent_$event",
    "timestamp": DateTime.now().millisecondsSinceEpoch,
    "deviceID": device.id,
    "data": data
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode >= 200 && response.statusCode < 300) {
    logger.i(await response.stream.bytesToString());
  } else {
    logger.e(response.reasonPhrase);
  }
}
