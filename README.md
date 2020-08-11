# dio_proxy_plugin [![Pub](https://img.shields.io/pub/v/dio_proxy_plugin.svg?style=flat-square)](https://pub.dartlang.org/packages/dio_proxy_plugin)

A new Flutter package project.

## Getting Started

### Install

```yaml
dependencies:
  dio_proxy: x.x.x #latest version
```

### Usage

已经成功在iOS、Android（华为和Vivo机型）下获取到系统代理，用charles抓包成功

```dart
import 'package:dio/dio.dart';
import 'package:dio_proxy/dio_proxy.dart';

void main() async{

    Dio dio = Dio()
      ..options.baseUrl = "https://httpbin.org/"
      ..httpClientAdapter = HttpProxyAdapter(ipAddr: 'localhost', port: 8888);
    
    //只在调试环境下启用代理
    if (!kReleaseMode) {
      //获取系统代理
      String deviceProxy = '';
      try {
        deviceProxy = await DioProxyPlugin.deviceProxy;
      } on PlatformException {
        deviceProxy = '';
        print('Failed to get system proxy.');
      }
      if (null != deviceProxy && deviceProxy.isNotEmpty) {
        var arrProxy = deviceProxy.split(':');

        //设置dio proxy
        var httpProxyAdapter = HttpProxyAdapter(
            ipAddr: arrProxy[0], port: int.tryParse(arrProxy[1]));
        dio.httpClientAdapter = httpProxyAdapter;
      }

    Response<String> response = await dio.get('/get?a=2');
    print(response.data);

    response = await dio.post('/post', data: {"a": 2});
    print(response.data);
}

```
