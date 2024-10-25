import Flutter
import UIKit
import ActitoKit
import ActitoInAppMessagingKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class SwiftActitoInAppMessagingPlugin: NSObject, FlutterPlugin {
    private static let instance = SwiftActitoInAppMessagingPlugin()
    private let events = ActitoInAppMessagingPluginEvents(packageId: "com.actito.iam.flutter")

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.iam.flutter/actito_in_app_messaging", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)

        instance.events.setup(registrar: registrar)
        Actito.shared.inAppMessaging().delegate = instance
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "hasMessagesSuppressed": hasMessagesSuppressed(call, result)
        case "setMessagesSuppressed": setMessagesSuppressed(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Methods

    private func hasMessagesSuppressed(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        response(Actito.shared.inAppMessaging().hasMessagesSuppressed)
    }

    private func setMessagesSuppressed(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any] else {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Invalid request parameters.", details: nil))
            return
        }
        
        let suppressed = arguments["suppressed"] as! Bool
        let evaluateContext = arguments["evaluateContext"] as? Bool ?? false
        
        Actito.shared.inAppMessaging().setMessagesSuppressed(suppressed, evaluateContext: evaluateContext)
        
        response(nil)
    }
}

extension SwiftActitoInAppMessagingPlugin: ActitoInAppMessagingDelegate {
    public func actito(_ actito: ActitoInAppMessaging, didPresentMessage message: ActitoInAppMessage) {
        events.emit(ActitoInAppMessagingPluginEvents.OnMessagePresented(message: message))
    }

    public func actito(_ actito: ActitoInAppMessaging, didFinishPresentingMessage message: ActitoInAppMessage) {
        events.emit(ActitoInAppMessagingPluginEvents.OnMessageFinishedPresenting(message: message))
    }

    public func actito(_ actito: ActitoInAppMessaging, didFailToPresentMessage message: ActitoInAppMessage) {
        events.emit(ActitoInAppMessagingPluginEvents.OnMessageFailedToPresent(message: message))
    }

    public func actito(_ actito: ActitoInAppMessaging, didExecuteAction action: ActitoInAppMessage.Action, for message: ActitoInAppMessage) {
        events.emit(ActitoInAppMessagingPluginEvents.OnActionExecuted(message: message, action: action))
    }

    public func actito(_ actito: ActitoInAppMessaging, didFailToExecuteAction action: ActitoInAppMessage.Action, for message: ActitoInAppMessage, error: Error?) {
        events.emit(ActitoInAppMessagingPluginEvents.OnActionFailedToExecute(message: message, action: action, error: error))
    }
}
