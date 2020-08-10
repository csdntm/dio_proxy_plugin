#import "DioProxyPlugin.h"

@implementation DioProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"csdn.net/dio_proxy_plugin"
            binaryMessenger:[registrar messenger]];
  DioProxyPlugin* instance = [[DioProxyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  if ([@"getDeviceProxy" isEqualToString:call.method]) {
      CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
      NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
      
      if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
          NSString *proxyHost = [dictProxy objectForKey:@"HTTPProxy"];    
          int proxyPort = [[dictProxy objectForKey:@"HTTPPort"] intValue];
          result([NSString stringWithFormat:@"%@:%d", proxyHost, proxyPort]);
      } else {
          result(nil);
      }    
  } else{
    result(FlutterMethodNotImplemented);
  }
}

@end
