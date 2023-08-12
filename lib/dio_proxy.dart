library dio_proxy;

import 'dart:io';

import 'package:dio/io.dart';

/// HttpProxyAdapter
/// [ipAddr] ip地址，默认是localhost
/// [port] 端口，默认是8888
///
class HttpProxyAdapter extends IOHttpClientAdapter {
  final String ipAddr;
  final int port;

  HttpProxyAdapter({this.ipAddr = 'localhost', this.port = 8888}) {
    final HttpClient client = HttpClient();
    createHttpClient = () {
      var proxy = '$ipAddr:$port';
      client.findProxy = (url) {
        return 'PROXY $proxy';
      };

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
