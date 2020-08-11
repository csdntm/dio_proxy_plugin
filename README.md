# dio_proxy_plugin [![Pub](https://img.shields.io/pub/v/dio_proxy.svg?style=flat-square)](https://pub.dartlang.org/packages/dio_proxy)

A new Flutter package project.

## Getting Started

### Install

```yaml
dependencies:
  dio_proxy: x.x.x #latest version
```

### Usage

```dart
import 'package:dio/dio.dart';
import 'package:dio_proxy/dio_proxy.dart';

void main() async{

    Dio dio = Dio()
      ..options.baseUrl = "https://httpbin.org/"
      ..httpClientAdapter = HttpProxyAdapter(ipAddr: 'localhost', port: 8888);
    
    Response<String> response = await dio.get('/get?a=2');
    print(response.data);

    response = await dio.post('/post', data: {"a": 2});
    print(response.data);
}

```
