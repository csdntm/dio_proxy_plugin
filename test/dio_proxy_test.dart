import 'package:dio/dio.dart';
import 'package:dio_proxy_plugin/dio_proxy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dio proxy', () async {
    var dio = Dio()..options.baseUrl = 'https://httpbin.org/';

    var httpProxyAdapter = HttpProxyAdapter(ipAddr: 'localhost', port: 8888);
    dio.httpClientAdapter = httpProxyAdapter;
    var response = await dio.get('/get?a=2');
    print(response.data);
    // expect(response.data, contains('args'));
    response = await dio.post('/post', data: {'a': 2});
    print(response.data);
    // expect(response.data, contains('args'));
  });
}
