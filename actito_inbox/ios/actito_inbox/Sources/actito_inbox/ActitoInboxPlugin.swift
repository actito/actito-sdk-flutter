import ActitoInboxKit
import ActitoKit
import Flutter
import UIKit

private let DEFAULT_ERROR_CODE = "actito_error"

public class ActitoInboxPlugin: NSObject, FlutterPlugin {
    static let instance = ActitoInboxPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance.register(with: registrar)
    }

    private let events = ActitoInboxPluginEvents(packageId: "com.actito.inbox.flutter")

    private func register(with registrar: FlutterPluginRegistrar) {
        // Delegate
        onMainThreadIsolated {
            Actito.shared.inbox().delegate = self
        }

        // Events
        events.setup(registrar: registrar)

        // Communication channel
        let channel = FlutterMethodChannel(
            name: "com.actito.inbox.flutter/actito_inbox",
            binaryMessenger: registrar.messenger(),
            codec: FlutterJSONMethodCodec.sharedInstance()
        )

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "getItems": self.getItems(call, result)
            case "getBadge": self.getBadge(call, result)
            case "refresh": self.refresh(call, result)
            case "open": self.open(call, result)
            case "markAsRead": self.markAsRead(call, result)
            case "markAllAsRead": self.markAllAsRead(call, result)
            case "remove": self.remove(call, result)
            case "clear": self.clear(call, result)

            // Unhandled
            default: result(FlutterMethodNotImplemented)
            }
        }
    }

    private func getItems(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            do {
                let items = try Actito.shared.inbox().items.map { item in
                    try item.toJson()
                }

                response(items)
            } catch {
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func getBadge(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            response(Actito.shared.inbox().badge)
        }
    }

    private func refresh(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            Actito.shared.inbox().refresh { result in
                switch result {
                case .success:
                    response(nil)
                case let .failure(error):
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    private func open(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        DispatchQueue.main.async {
            Actito.shared.inbox().open(item) { result in
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
    }

    private func markAsRead(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        DispatchQueue.main.async {
            Actito.shared.inbox().markAsRead(item) { result in
                switch result {
                case .success:
                    response(nil)
                case let .failure(error):
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    private func markAllAsRead(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            Actito.shared.inbox().markAllAsRead { result in
                switch result {
                case .success:
                    response(nil)
                case let .failure(error):
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    private func remove(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let item: ActitoInboxItem

        do {
            let json = call.arguments as! [String: Any]
            item = try ActitoInboxItem.fromJson(json: json)
        } catch {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            return
        }

        DispatchQueue.main.async {
            Actito.shared.inbox().remove(item) { result in
                switch result {
                case .success:
                    response(nil)
                case let .failure(error):
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    private func clear(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            Actito.shared.inbox().clear { result in
                switch result {
                case .success:
                    response(nil)
                case let .failure(error):
                    response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
                }
            }
        }
    }
}

extension ActitoInboxPlugin: ActitoInboxDelegate {
    public func actito(_ actitoInbox: ActitoInbox, didUpdateInbox items: [ActitoInboxItem]) {
        events.emit(
            ActitoInboxPluginEvents.OnInboxUpdated(items: items)
        )
    }

    public func actito(_ actitoInbox: ActitoInbox, didUpdateBadge badge: Int) {
        events.emit(
            ActitoInboxPluginEvents.OnBadgeUpdated(badge: badge)
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
        var result: T! = nil

        group.enter()

        DispatchQueue.main.async {
            result = block()
            group.leave()
        }

        group.wait()
        return result
    }
}
