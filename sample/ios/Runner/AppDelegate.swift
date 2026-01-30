import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let infoChannel = FlutterMethodChannel(name: "com.actito.sample/info", binaryMessenger: controller.binaryMessenger)

        infoChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "getActitoServicesInfo": self?.getActitoServicesInfo(call, result)

            default: result(FlutterMethodNotImplemented)
            }
        })

        GeneratedPluginRegistrant.register(with: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getActitoServicesInfo(_ call: FlutterMethodCall, _ result: FlutterResult) {
        guard let path = Bundle.main.path(forResource: "ActitoServices", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: String]
        else {
            fatalError("ActitoServices.plist is missing or invalid.")
        }

        guard let applicationKey = dict["APPLICATION_KEY"] as? String,
              let applicationSecret = dict["APPLICATION_SECRET"] as? String
        else {
            fatalError("Missing values in ActitoServices.plist")
        }

        let resultMap: [String: Any] = [
            "applicationKey": applicationKey,
            "applicationSecret": applicationSecret
        ]

        result(resultMap)
    }
}
