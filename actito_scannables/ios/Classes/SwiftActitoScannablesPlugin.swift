import Flutter
import UIKit
import ActitoKit
import ActitoScannablesKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class SwiftActitoScannablesPlugin: NSObject, FlutterPlugin {
    private static let instance = SwiftActitoScannablesPlugin()
    private let events = ActitoScannablesPluginEvents(packageId: "com.actito.scannables.flutter")
    
    private var rootViewController: UIViewController? {
        get {
            UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.scannables.flutter/actito_scannables", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        instance.events.setup(registrar: registrar)
        Actito.shared.scannables().delegate = instance
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "canStartNfcScannableSession": canStartNfcScannableSession(call, result)
        case "startScannableSession": startScannableSession(call, result)
        case "startNfcScannableSession": startNfcScannableSession(call, result)
        case "startQrCodeScannableSession": startQrCodeScannableSession(call, result)
        case "fetch": fetch(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK: - Methods
    
    private func canStartNfcScannableSession(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        response(Actito.shared.scannables().canStartNfcScannableSession)
    }
    
    private func startScannableSession(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        guard let rootViewController = rootViewController else {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Cannot start a scannable session with a nil root view controller.", details: nil))
            return
        }
        
        Actito.shared.scannables().startScannableSession(controller: rootViewController)
        response(nil)
    }
    
    private func startNfcScannableSession(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        Actito.shared.scannables().startNfcScannableSession()
        response(nil)
    }
    
    private func startQrCodeScannableSession(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        guard let rootViewController = rootViewController else {
            response(FlutterError(code: DEFAULT_ERROR_CODE, message: "Cannot start a scannable session with a nil root view controller.", details: nil))
            return
        }
        
        Actito.shared.scannables().startQrCodeScannableSession(controller: rootViewController, modal: true)
        response(nil)
    }
    
    private func fetch(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        let tag = call.arguments as! String
        
        Actito.shared.scannables().fetch(tag: tag) { result in
            switch result {
            case let .success(scannable):
                do {
                    let json = try scannable.toJson()
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

extension SwiftActitoScannablesPlugin: ActitoScannablesDelegate {
    public func actito(_ actitoScannables: ActitoScannables, didDetectScannable scannable: ActitoScannable) {
        events.emit(ActitoScannablesPluginEvents.OnScannableDetected(scannable: scannable))
    }
    
    public func actito(_ actitoScannables: ActitoScannables, didInvalidateScannerSession error: Error) {
        events.emit(ActitoScannablesPluginEvents.OnScannableSessionFailed(error: error))
    }
}
