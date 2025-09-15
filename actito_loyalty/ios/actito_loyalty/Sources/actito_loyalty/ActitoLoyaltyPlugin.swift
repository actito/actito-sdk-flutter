import ActitoKit
import ActitoLoyaltyKit
import Flutter
import UIKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class ActitoLoyaltyPlugin: NSObject, FlutterPlugin {

    private static let instance = ActitoLoyaltyPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.loyalty.flutter/actito_loyalty", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "fetchPassBySerial": fetchPassBySerial(call, result)
        case "fetchPassByBarcode": fetchPassByBarcode(call, result)
        case "present": present(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Methods

    private func fetchPassBySerial(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let serial = call.arguments as! String

        Actito.shared.loyalty().fetchPass(serial: serial) { result in
            switch result {
            case let .success(pass):
                do {
                    let json = try pass.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func fetchPassByBarcode(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let barcode = call.arguments as! String

        Actito.shared.loyalty().fetchPass(barcode: barcode) { result in
            switch result {
            case let .success(pass):
                do {
                    let json = try pass.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func present(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let pass: ActitoPass

        do {
            let json = call.arguments as! [String: Any]
            pass = try ActitoPass.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Cannot present a pass with a nil root view controller.", details: nil))
            return
        }

        Actito.shared.loyalty().present(pass: pass, in: rootViewController)
        response(nil)
    }
}
