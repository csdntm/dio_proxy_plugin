import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_proxy_plugin/dio_proxy_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceProxy = '';

  Future<void> _setProxy() async {
    String deviceProxy = '';
    var dio = Dio()..options.baseUrl = 'https://httpbin.org/';

    if (!kReleaseMode) {
      try {
        deviceProxy = await DioProxyPlugin.deviceProxy;
      } on PlatformException {
        deviceProxy = '';
        print('Failed to get system proxy.');
      }
      if (deviceProxy.isNotEmpty) {
        var arrProxy = deviceProxy.split(':');
        final port = int.tryParse(arrProxy[1]) ?? 8888;
        //设置dio proxy
        var httpProxyAdapter =
            HttpProxyAdapter(ipAddr: arrProxy[0], port: port);
        dio.httpClientAdapter = httpProxyAdapter;
      }

      // test dio
      var response = await dio.get('/get?a=2');
      print(response.data);
      response = await dio.post('/post', data: {'a': 2});
      print(response.data);
    }

    if (!mounted) return;

    setState(() {
      _deviceProxy = deviceProxy;
    });
  }

  @override
  void initState() {
    super.initState();
    _setProxy();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: GestureDetector(
            onTap: () {
              _setProxy();
              print("set Proxy");
            },
            child: Center(
              child: Text('Device proxy: $_deviceProxy\n'),
            ),
          )),
    );
  }
}
