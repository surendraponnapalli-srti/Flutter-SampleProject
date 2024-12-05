import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('ai.securiti/nativeFramework');

  Future<void> callNativeMethod() async {
try {
      final String result = await platform.invokeMethod('methodName', {"appUrl": "https://dev-intg-2.securiti.xyz/","cdnUrl": "https://cdn-dev-intg-2.securiti.xyz/","tenantId": "d525a59e-896e-4a85-ad1a-84921e9acce0",
"appId": "a2d3c183-0a3c-4bb9-ba3b-6b6de1949ed3"});
      print('Native method result: $result');
    } on PlatformException catch (e) {
      print("Error calling native method: ${e.message}");
    }

  }
}
