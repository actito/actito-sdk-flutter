import ActitoAssetsKit
import ActitoKit
import Flutter
import UIKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class SwiftActitoAssetsPlugin: NSObject, FlutterPlugin {

    private static let instance = SwiftActitoAssetsPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.assets.flutter/actito_assets", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "fetch": fetch(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Methods

    private func fetch(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let group = call.arguments as! String

        Actito.shared.assets().fetch(group: group) { result in
            switch result {
            case let .success(assets):
                do {
                    let json = try assets.map { try $0.toJson() }
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }
}
