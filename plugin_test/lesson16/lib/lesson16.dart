
import 'dart:async';

import 'package:flutter/services.dart';

class Lesson16 {
  static const MethodChannel _channel = MethodChannel('lesson16');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  Future<void> openBrowser(String urlString) async {
    try {
      final int result = await _channel.invokeMethod(
          'openBrowser', <String, String>{ 'url': urlString }
      );
    }
    on PlatformException catch (e) {
      print(e);
    }
  }

}
