import ActitoKit
import ActitoUserInboxKit
import Flutter
import UIKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class SwiftActitoUserInboxPlugin: NSObject, FlutterPlugin {

    static let instance = SwiftActitoUserInboxPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.inbox.user.flutter/actito_user_inbox", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "parseResponseFromJSON": parseResponseFromJSON(call, result)
        case "parseResponseFromString": parseResponseFromString(call, result)
        case "open": open(call, result)
        case "markAsRead": markAsRead(call, result)
        case "remove": remove(call, result)

            // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Methods

    private func parseResponseFromJSON(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        do {
            let json = call.arguments as! [String: Any]

            let result = try Actito.shared.userInbox().parseResponse(json: json)

            response(try result.toJson())
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
        }
    }

    private func parseResponseFromString(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        do {
            let json = call.arguments as! String

            let result = try Actito.shared.userInbox().parseResponse(string: json)

            response(try result.toJson())
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
        }
    }

    private func open(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoUserInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoUserInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        Actito.shared.userInbox().open(item) { result in
            switch result {
            case let .success(notification):
                do {
                    let json = try notification.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func markAsRead(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoUserInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoUserInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        Actito.shared.userInbox().markAsRead(item) { result in
            switch result {
            case .success:
                response(nil)
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func remove(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoUserInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoUserInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        Actito.shared.userInbox().remove(item) { result in
            switch result {
            case .success:
                response(nil)
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }
}
