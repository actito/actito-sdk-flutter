import ActitoKit
import ActitoPushUIKit
import Flutter
import UIKit

private let DEFAULT_ERROR_CODE = "actito_error"
private let NAMESPACE = "com.actito.push.ui.flutter"

public class ActitoPushUIPlugin: NSObject, FlutterPlugin {
    static let instance = ActitoPushUIPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance.register(with: registrar)
    }

    private let eventBroker = ActitoPushUIPluginEventBroker(namespace: NAMESPACE)

    private var rootViewController: UIViewController? {
        get {
            UIApplication.shared.delegate?.window??.rootViewController
        }
    }

    private func register(with registrar: FlutterPluginRegistrar) {
        // Events
        eventBroker.setup(registrar: registrar)

        // Delegate
        onMainThreadIsolated {
            Actito.shared.pushUI().delegate = self
        }

        let channel = FlutterMethodChannel(name: "\(NAMESPACE)/actito_push_ui", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(self, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "presentNotification": presentNotification(call, result)
        case "presentAction": presentAction(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    private func presentNotification(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let notification: ActitoNotification

        do {
            let json = call.arguments as! [String: Any]
            notification = try ActitoNotification.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        DispatchQueue.main.async {
            guard let rootViewController = self.rootViewController else {
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Cannot present a notification with a nil root view controller.", details: nil))
                return
            }

            if notification.requiresViewController {
                let navigationController = self.createNavigationController()
                rootViewController.present(navigationController, animated: true) {
                    Actito.shared.pushUI().presentNotification(notification, in: navigationController)
                    response(nil)
                }
            } else {
                Actito.shared.pushUI().presentNotification(notification, in: rootViewController)
                response(nil)
            }
        }
    }

    private func presentAction(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let notification: ActitoNotification
        let action: ActitoNotification.Action

        do {
            let json = call.arguments as! [String: Any]
            notification = try ActitoNotification.fromJson(json: json["notification"] as! [String: Any])
            action = try ActitoNotification.Action.fromJson(json: json["action"] as! [String: Any])
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        DispatchQueue.main.async {
            guard let rootViewController = self.rootViewController else {
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Cannot present a notification with a nil root view controller.", details: nil))
                return
            }

            Actito.shared.pushUI().presentAction(action, for: notification, in: rootViewController)
            response(nil)
        }
    }

    @MainActor
    private func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let theme = Actito.shared.options?.theme(for: navigationController)

        if let colorStr = theme?.backgroundColor {
            navigationController.view.backgroundColor = UIColor(hexString: colorStr)
        } else {
            if #available(iOS 13.0, *) {
                navigationController.view.backgroundColor = .systemBackground
            } else {
                navigationController.view.backgroundColor = .white
            }
        }

        return navigationController
    }

    @objc private func onCloseClicked() {
        guard let rootViewController = rootViewController else {
            return
        }

        rootViewController.dismiss(animated: true, completion: nil)
    }
}

extension ActitoPushUIPlugin: ActitoPushUIDelegate {
    public func actito(_ actitoPushUI: ActitoPushUI, willPresentNotification notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnNotificationWillPresent(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didPresentNotification notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnNotificationPresented(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didFinishPresentingNotification notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnNotificationFinishedPresenting(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didFailToPresentNotification notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnNotificationFailedToPresent(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didClickURL url: URL, in notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnNotificationUrlClicked(
                notification: notification,
                url: url
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, willExecuteAction action: ActitoNotification.Action, for notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnActionWillExecute(
                notification: notification,
                action: action
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didExecuteAction action: ActitoNotification.Action, for notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnActionExecuted(
                notification: notification,
                action: action
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didNotExecuteAction action: ActitoNotification.Action, for notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnActionNotExecuted(
                notification: notification,
                action: action
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didFailToExecuteAction action: ActitoNotification.Action, for notification: ActitoNotification, error: Error?) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnActionFailedToExecute(
                notification: notification,
                action: action,
                error: error
            )
        )
    }

    public func actito(_ actitoPushUI: ActitoPushUI, didReceiveCustomAction url: URL, in action: ActitoNotification.Action, for notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushUIPluginEventBroker.OnCustomActionReceived(
                notification: notification,
                action: action,
                url: url
            )
        )
    }
}

internal func onMainThreadIsolated<T>(_ block: @MainActor @escaping () -> T) -> T {
    if Thread.isMainThread {
        return MainActor.assumeIsolated {
            block()
        }
    } else {
        let group = DispatchGroup()
        var result: T!

        group.enter()

        DispatchQueue.main.async {
            result = block()
            group.leave()
        }

        group.wait()
        return result
    }
}
