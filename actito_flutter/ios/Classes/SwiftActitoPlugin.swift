import Flutter
import UIKit
import ActitoKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class SwiftActitoPlugin: NSObject, FlutterPlugin {

    static let instance = SwiftActitoPlugin()

    private var channel: FlutterMethodChannel!

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance.register(with: registrar)
    }

    private func register(with registrar: FlutterPluginRegistrar) {
        registrar.addApplicationDelegate(self)

        // Events
        ActitoEventManager.shared.register(for: registrar)

        // Delegate
        Actito.shared.delegate = self

        // Communication channel
        channel = FlutterMethodChannel(name: "com.actito.flutter/actito", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        channel.setMethodCallHandler { (call, result) in
            switch call.method {

            // Actito
            case "isConfigured": self.isConfigured(call, result)
            case "isReady": self.isReady(call, result)
            case "launch": self.launch(call, result)
            case "unlaunch": self.unlaunch(call, result)
            case "getApplication": self.getApplication(call, result)
            case "fetchApplication": self.fetchApplication(call, result)
            case "fetchNotification": self.fetchNotification(call, result)
            case "fetchDynamicLink": self.fetchDynamicLink(call, result)
            case "canEvaluateDeferredLink": self.canEvaluateDeferredLink(call, result)
            case "evaluateDeferredLink": self.evaluateDeferredLink(call, result)

            // Actito Device Module
            case "getCurrentDevice": self.getCurrentDevice(call, result)
            case "register": self.register(call, result)
            case "updateUser": self.updateUser(call, result)
            case "fetchTags": self.fetchTags(call, result)
            case "addTag": self.addTag(call, result)
            case "addTags": self.addTags(call, result)
            case "removeTag": self.removeTag(call, result)
            case "removeTags": self.removeTags(call, result)
            case "clearTags": self.clearTags(call, result)
            case "getPreferredLanguage": self.getPreferredLanguage(call, result)
            case "updatePreferredLanguage": self.updatePreferredLanguage(call, result)
            case "fetchDoNotDisturb": self.fetchDoNotDisturb(call, result)
            case "updateDoNotDisturb": self.updateDoNotDisturb(call, result)
            case "clearDoNotDisturb": self.clearDoNotDisturb(call, result)
            case "fetchUserData": self.fetchUserData(call, result)
            case "updateUserData": self.updateUserData(call, result)

            // Actito Events Module
            case "logCustom": self.logCustom(call, result)

            // Unhandled
            default: result(FlutterMethodNotImplemented)
            }
        }
    }

    //    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    //
    //    }

    // MARK: - Actito

    private func isConfigured(_ call: FlutterMethodCall, _ result: FlutterResult) {
        result(Actito.shared.isConfigured)
    }

    private func isReady(_ call: FlutterMethodCall, _ result: FlutterResult) {
        result(Actito.shared.isReady)
    }

    private func launch(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.launch { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func unlaunch(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.unlaunch { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func getApplication(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        do {
            let json = try Actito.shared.application?.toJson()
            response(json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
        }
    }

    private func fetchApplication(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.fetchApplication { result in
            switch result {
            case let .success(application):
                do {
                    let json = try application.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func fetchNotification(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let id = call.arguments as! String

        Actito.shared.fetchNotification(id) { result in
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

    private func fetchDynamicLink(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let url = call.arguments as! String

        Actito.shared.fetchDynamicLink(url) { result in
            switch result {
            case let .success(dynamicLink):
                do {
                    let json = try dynamicLink.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func canEvaluateDeferredLink(_ call: FlutterMethodCall, _ response: FlutterResult) {
        response(Actito.shared.canEvaluateDeferredLink)
    }

    private func evaluateDeferredLink(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.evaluateDeferredLink { result in
            switch result {
            case let .success(evaluated):
                response(evaluated)
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    // MARK: - Actito Device Manager

    private func getCurrentDevice(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        do {
            let json = try Actito.shared.device().currentDevice?.toJson()
            response(json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
        }
    }

    private func register(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let arguments = call.arguments as! FlutterDictionary

        Actito.shared.device().register(
            userId: arguments["userId"] as? String,
            userName: arguments["userName"] as? String
        ) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func updateUser(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let arguments = call.arguments as! FlutterDictionary

        Actito.shared.device().updateUser(
            userId: arguments["userId"] as? String,
            userName: arguments["userName"] as? String
        ) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func fetchTags(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.device().fetchTags { result in
            switch result {
            case .success(let tags):
                response(tags)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func addTag(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let tag = call.arguments as! String

        Actito.shared.device().addTag(tag) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func addTags(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let tags = call.arguments as! [String]

        Actito.shared.device().addTags(tags) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func removeTag(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let tag = call.arguments as! String

        Actito.shared.device().removeTag(tag) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func removeTags(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let tags = call.arguments as! [String]

        Actito.shared.device().removeTags(tags) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func clearTags(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        Actito.shared.device().clearTags { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func getPreferredLanguage(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        response(Actito.shared.device().preferredLanguage)
    }

    private func updatePreferredLanguage(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let language = call.arguments as! String?

        Actito.shared.device().updatePreferredLanguage(language) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func fetchDoNotDisturb(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        Actito.shared.device().fetchDoNotDisturb { result in
            switch result {
            case .success(let dnd):
                do {
                    let json = try dnd?.toJson()
                    response(json)
                } catch {
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func updateDoNotDisturb(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let dnd: ActitoDoNotDisturb

        do {
            let json = call.arguments as! [String: Any]
            dnd = try ActitoDoNotDisturb.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        Actito.shared.device().updateDoNotDisturb(dnd) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func clearDoNotDisturb(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        Actito.shared.device().clearDoNotDisturb { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func fetchUserData(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        Actito.shared.device().fetchUserData { result in
            switch result {
            case .success(let userData):
                response(userData)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func updateUserData(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let userData = call.arguments as! [String: String?]

        Actito.shared.device().updateUserData(userData) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    // MARK: - Actito Events Manager

    private func logCustom(_ call: FlutterMethodCall, _ response: @escaping  FlutterResult) {
        let arguments = call.arguments as! [String: Any]

        let eventName = arguments["event"] as! String
        let eventData = arguments["data"] as? [String: Any]

        Actito.shared.events().logCustom(eventName, data: eventData) { result in
            switch result {
            case .success:
                response(nil)
            case .failure(let error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }
}

extension SwiftActitoPlugin {
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Actito.shared.handleTestDeviceUrl(url) {
            return true
        }

        if Actito.shared.handleDynamicLinkUrl(url) {
            return true
        }

        ActitoEventManager.shared.send(ActitoEventOnUrlOpened(url: url.absoluteString))
        return false
    }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]) -> Void) -> Bool {
        guard let url = userActivity.webpageURL else {
            return false
        }

        if Actito.shared.handleTestDeviceUrl(url) {
            return true
        }

        return Actito.shared.handleDynamicLinkUrl(url)
    }
}

extension SwiftActitoPlugin: ActitoDelegate {

    public func actito(_ actito: Actito, onReady application: ActitoApplication) {
        ActitoEventManager.shared.send(ActitoEventOnReady(application: application))
    }

    public func actito(_ actito: Actito) {
        ActitoEventManager.shared.send(ActitoEventOnUnlaunched())
    }

    public func actito(_ actito: Actito, didRegisterDevice device: ActitoDevice) {
        ActitoEventManager.shared.send(ActitoEventOnDeviceRegistered(device: device))
    }
}
