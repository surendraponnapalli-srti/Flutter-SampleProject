import Flutter
import UIKit
import ConsentUI
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let vc: FlutterViewController = window.rootViewController as! FlutterViewController
      
      let channel = FlutterMethodChannel(name: "ai.securiti/nativeFramework", binaryMessenger: vc as! FlutterBinaryMessenger)
            
      channel.setMethodCallHandler { (call, result) in
          if call.method == "methodName" {
              // Call the corresponding native method from YourNativeFramework
              if let argument = call.arguments as? [String: Any] {
                  let appUrl = argument["appUrl"] as! String
                  let cdnUrl = argument["cdnUrl"] as! String
                  let tenantId = argument["tenantId"] as! String
                  let appId = argument["appId"] as! String
                  self.callingCustomerAppIOSFramework(appUrl: appUrl, cdnUrl: cdnUrl, tenantId: tenantId, appId: appId)
              }
          } else {
          }
      }
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func callingCustomerAppIOSFramework(appUrl:String,cdnUrl:String,tenantId:String,appId:String) {
        ConsentSDK.shared.setupSDK(options:
            ConsentSDKOptions(
                appUrl: appUrl,
                cdnUrl: cdnUrl,
                tenantId: tenantId,
                appId: appId,
                testingMode: true,
                logLevel: .debug,
                consentsCheckInterval: 60,
                languageCode: "en",
                locationCode: "AQ"
            )
        )
        ConsentSDK.shared.isReady() { state in
            print(state.status())
            if state == .available {
                ConsentSDK.shared.presentConsentBanner()
            }
        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
