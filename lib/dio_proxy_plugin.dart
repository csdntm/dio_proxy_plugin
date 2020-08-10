import 'dart:async';

import 'package:flutter/services.dart';

export 'dio_proxy.dart';

class DioProxyPlugin {
  static const MethodChannel _channel = const MethodChannel('dio_proxy_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
