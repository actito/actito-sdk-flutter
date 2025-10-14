import ActitoKit
import ActitoPushKit
import Flutter
import UIKit

fileprivate let DEFAULT_ERROR_CODE = "actito_error"
fileprivate let NAMESPACE = "com.actito.push.flutter"

@MainActor
public class ActitoPushPlugin: NSObject, FlutterPlugin {
    static let instance = ActitoPushPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance.register(with: registrar)
    }

    private let eventBroker = ActitoPushPluginEventBroker(namespace: NAMESPACE)

    private func register(with registrar: FlutterPluginRegistrar) {
        // Events
        eventBroker.setup(registrar: registrar)

        // Delegate
        Actito.shared.push().delegate = self

        // NOTE: We need to have a blank implementation of the didReceiveRemoteNotification to allow the native
        // side to swizzle the method.
        registrar.addApplicationDelegate(self)

        // Communication channel
        let channel = FlutterMethodChannel(
            name: "\(NAMESPACE)/actito_push",
            binaryMessenger: registrar.messenger(),
            codec: FlutterJSONMethodCodec.sharedInstance()
        )

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "setAuthorizationOptions": self.setAuthorizationOptions(call, result)
            case "setCategoryOptions": self.setCategoryOptions(call, result)
            case "setPresentationOptions": self.setPresentationOptions(call, result)
            case "hasRemoteNotificationsEnabled": self.hasRemoteNotificationsEnabled(call, result)
            case "getTransport": self.getTransport(call, result)
            case "getSubscription": self.getSubscription(call, result)
            case "allowedUI": self.allowedUI(call, result)
            case "enableRemoteNotifications": self.enableRemoteNotifications(call, result)
            case "disableRemoteNotifications": self.disableRemoteNotifications(call, result)

            // Unhandled
            default: result(FlutterMethodNotImplemented)
            }
        }
    }

    private func setAuthorizationOptions(_ call: FlutterMethodCall, _ response: FlutterResult) {
        var authorizationOptions: UNAuthorizationOptions = []

        let options = call.arguments as! [String]
        options.forEach { option in
            if option == "alert" {
                authorizationOptions = [authorizationOptions, .alert]
            }

            if option == "badge" {
                authorizationOptions = [authorizationOptions, .badge]
            }

            if option == "sound" {
                authorizationOptions = [authorizationOptions, .sound]
            }

            if option == "carPlay" {
                authorizationOptions = [authorizationOptions, .carPlay]
            }

            if #available(iOS 12.0, *) {
                if option == "providesAppNotificationSettings" {
                    authorizationOptions = [authorizationOptions, .providesAppNotificationSettings]
                }

                if option == "provisional" {
                    authorizationOptions = [authorizationOptions, .provisional]
                }

                if option == "criticalAlert" {
                    authorizationOptions = [authorizationOptions, .criticalAlert]
                }
            }

            if #available(iOS 13.0, *) {
                if option == "announcement" {
                    authorizationOptions = [authorizationOptions, .announcement]
                }
            }
        }

        Actito.shared.push().authorizationOptions = authorizationOptions
        response(nil)
    }

    private func setCategoryOptions(_ call: FlutterMethodCall, _ response: FlutterResult) {
        var categoryOptions: UNNotificationCategoryOptions = []

        let options = call.arguments as! [String]
        options.forEach { option in
            if option == "customDismissAction" {
                categoryOptions = [categoryOptions, .customDismissAction]
            }

            if option == "allowInCarPlay" {
                categoryOptions = [categoryOptions, .allowInCarPlay]
            }

            if #available(iOS 11.0, *) {
                if option == "hiddenPreviewsShowTitle" {
                    categoryOptions = [categoryOptions, .hiddenPreviewsShowTitle]
                }

                if option == "hiddenPreviewsShowSubtitle" {
                    categoryOptions = [categoryOptions, .hiddenPreviewsShowSubtitle]
                }
            }

            if #available(iOS 13.0, *) {
                if option == "allowAnnouncement" {
                    categoryOptions = [categoryOptions, .allowAnnouncement]
                }
            }
        }

        Actito.shared.push().categoryOptions = categoryOptions
        response(nil)
    }

    private func setPresentationOptions(_ call: FlutterMethodCall, _ response: FlutterResult) {
        var presentationOptions: UNNotificationPresentationOptions = []

        let options = call.arguments as! [String]
        options.forEach { option in
            if #available(iOS 14.0, *) {
                if option == "banner" || option == "alert" {
                    presentationOptions = [presentationOptions, .banner]
                }

                if option == "list" {
                    presentationOptions = [presentationOptions, .list]
                }
            } else {
                if option == "alert" {
                    presentationOptions = [presentationOptions, .alert]
                }
            }

            if option == "badge" {
                presentationOptions = [presentationOptions, .badge]
            }

            if option == "sound" {
                presentationOptions = [presentationOptions, .sound]
            }
        }

        Actito.shared.push().presentationOptions = presentationOptions
        response(nil)
    }

    private func hasRemoteNotificationsEnabled(_ call: FlutterMethodCall, _ response: FlutterResult) {
        response(Actito.shared.push().hasRemoteNotificationsEnabled)
    }

    private func getTransport(_ call: FlutterMethodCall, _ response: FlutterResult) {
        response(Actito.shared.push().transport?.rawValue)
    }

    private func getSubscription(_ call: FlutterMethodCall, _ response: FlutterResult) {
        do {
            let json = try Actito.shared.push().subscription?.toJson()
            response(json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
        }
    }

    private func allowedUI(_ call: FlutterMethodCall, _ response: FlutterResult) {
        response(Actito.shared.push().allowedUI)
    }

    private func enableRemoteNotifications(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.push().enableRemoteNotifications { result in
            switch result {
            case .success:
                response(nil)
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func disableRemoteNotifications(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.push().disableRemoteNotifications { result in
            switch result {
            case .success:
                response(nil)
            case let .failure(error):
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }
}

extension ActitoPushPlugin: ActitoPushDelegate {
    public func actito(_ actitoPush: ActitoPush, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnFailedToRegisterForRemoteNotifications(
                error: error
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didChangeNotificationSettings granted: Bool) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnNotificationSettingsChanged(
                granted: granted
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didChangeSubscription subscription: ActitoPushSubscription?) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnSubscriptionChanged(
                subscription: subscription
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didReceiveNotification notification: ActitoNotification, deliveryMechanism: ActitoNotificationDeliveryMechanism) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnNotificationReceived(
                notification: notification,
                deliveryMechanism: deliveryMechanism
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didReceiveSystemNotification notification: ActitoSystemNotification) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnSystemNotificationReceived(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didReceiveUnknownNotification userInfo: [AnyHashable: Any]) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnUnknownNotificationReceived(
                userInfo: userInfo
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, shouldOpenSettings notification: ActitoNotification?) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnShouldOpenNotificationSettings(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didOpenNotification notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnNotificationOpened(
                notification: notification
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didOpenUnknownNotification userInfo: [AnyHashable: Any]) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnUnknownNotificationOpened(
                notification: userInfo
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didOpenAction action: ActitoNotification.Action, for notification: ActitoNotification) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnNotificationActionOpened(
                notification: notification,
                action: action
            )
        )
    }

    public func actito(_ actitoPush: ActitoPush, didOpenUnknownAction action: String, for notification: [AnyHashable: Any], responseText: String?) {
        eventBroker.emit(
            ActitoPushPluginEventBroker.OnUnknownNotificationActionOpened(
                notification: notification,
                action: action,
                responseText: responseText
            )
        )
    }
}

extension ActitoPushPlugin: FlutterApplicationLifeCycleDelegate {
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        // This method is never called. The swizzling performed on the native side takes care of it.
        return true
    }
}
