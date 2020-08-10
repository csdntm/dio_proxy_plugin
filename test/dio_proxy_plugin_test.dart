import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio_proxy_plugin/dio_proxy_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('dio_proxy_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DioProxyPlugin.platformVersion, '42');
  });
}
