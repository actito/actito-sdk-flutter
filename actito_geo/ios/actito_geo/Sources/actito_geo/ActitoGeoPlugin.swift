import ActitoGeoKit
import ActitoKit
import Flutter
import UIKit

private typealias FlutterDictionary = [String: Any?]
private let DEFAULT_ERROR_CODE = "actito_error"

public class ActitoGeoPlugin: NSObject, FlutterPlugin {

    private static let instance = ActitoGeoPlugin()
    private let events = ActitoGeoPluginEvents(packageId: "com.actito.geo.flutter")

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.actito.geo.flutter/actito_geo", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
        registrar.addMethodCallDelegate(instance, channel: channel)

        instance.events.setup(registrar: registrar)
        onMainThreadIsolated {
            Actito.shared.geo().delegate = instance
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "hasLocationServicesEnabled": hasLocationServicesEnabled(call, result)
        case "hasBluetoothEnabled": hasBluetoothEnabled(call, result)
        case "getMonitoredRegions": getMonitoredRegions(call, result)
        case "getEnteredRegions": getEnteredRegions(call, result)
        case "enableLocationUpdates": enableLocationUpdates(call, result)
        case "disableLocationUpdates": disableLocationUpdates(call, result)

        // Unhandled
        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Methods

    private func hasLocationServicesEnabled(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            response(Actito.shared.geo().hasLocationServicesEnabled)
        }
    }

    private func hasBluetoothEnabled(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            response(Actito.shared.geo().hasBluetoothEnabled)
        }
    }

    private func getMonitoredRegions(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            do {
                let regions = try Actito.shared.geo().monitoredRegions.map { region in
                    try region.toJson()
                }

                response(regions)
            } catch {
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func getEnteredRegions(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            do {
                let regions = try Actito.shared.geo().enteredRegions.map { region in
                    try region.toJson()
                }

                response(regions)
            } catch {
                response(FlutterError(code: DEFAULT_ERROR_CODE, message: error.localizedDescription, details: nil))
            }
        }
    }

    private func enableLocationUpdates(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            Actito.shared.geo().enableLocationUpdates()
            response(nil)
        }
    }

    private func disableLocationUpdates(_ call: FlutterMethodCall, _ response: @escaping FlutterResult) {
        DispatchQueue.main.async {
            Actito.shared.geo().disableLocationUpdates()
            response(nil)
        }
    }
}

extension ActitoGeoPlugin: ActitoGeoDelegate {
    public func actito(_ actitoGeo: ActitoGeo, didUpdateLocations locations: [ActitoLocation]) {
        guard let location = locations.first else { return }

        events.emit(
            ActitoGeoPluginEvents.OnLocationUpdated(location: location)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didEnter region: ActitoRegion) {
        events.emit(
            ActitoGeoPluginEvents.OnRegionEntered(region: region)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didExit region: ActitoRegion) {
        events.emit(
            ActitoGeoPluginEvents.OnRegionExited(region: region)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didEnter beacon: ActitoBeacon) {
        events.emit(
            ActitoGeoPluginEvents.OnBeaconEntered(beacon: beacon)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didExit beacon: ActitoBeacon) {
        events.emit(
            ActitoGeoPluginEvents.OnBeaconExited(beacon: beacon)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didRange beacons: [ActitoBeacon], in region: ActitoRegion) {
        events.emit(
            ActitoGeoPluginEvents.OnBeaconsRanged(beacons: beacons, in: region)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didVisit visit: ActitoVisit) {
        events.emit(
            ActitoGeoPluginEvents.OnVisit(visit: visit)
        )
    }

    public func actito(_ actitoGeo: ActitoGeo, didUpdateHeading heading: ActitoHeading) {
        events.emit(
            ActitoGeoPluginEvents.OnHeadingUpdated(heading: heading)
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
