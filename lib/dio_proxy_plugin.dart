import 'dart:async';

import 'package:flutter/services.dart';

export 'dio_proxy.dart';

class DioProxyPlugin {
  static const MethodChannel _channel =
      MethodChannel('csdn.net/dio_proxy_plugin');

  static Future<String> get deviceProxy async {
    final version = await _channel.invokeMethod('getDeviceProxy');
    return version;
  }
}
