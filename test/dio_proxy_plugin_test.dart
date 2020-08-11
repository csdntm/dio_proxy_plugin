import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio_proxy_plugin/dio_proxy_plugin.dart';

void main() {
  const channel = MethodChannel('csdn.net/dio_proxy_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'localhost:8888';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDeviceProxy', () async {
    expect(await DioProxyPlugin.deviceProxy, 'localhost:8888');
  });
}
