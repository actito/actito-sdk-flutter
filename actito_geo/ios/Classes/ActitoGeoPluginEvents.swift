//
//  ActitoGeoPluginEvents.swift
//  actito_geo
//
//  Created by Helder Pinhal on 24/11/2021.
//

import Foundation
import ActitoGeoKit

class ActitoGeoPluginEvents {
    private let packageId: String
    
    private var channels: [EventType: FlutterEventChannel] = [:]
    private var streams: [EventType: Stream]
    
    init(packageId: String) {
        var streams: [EventType: Stream] = [:]
        EventType.allCases.forEach { type in
            streams[type] = Stream(packageId: packageId, type: type)
        }
        
        self.packageId = packageId
        self.streams = streams
    }
    
    func setup(registrar: FlutterPluginRegistrar) {
        streams.values.forEach { stream in
            if let channel = channels[stream.type] {
                channel.setStreamHandler(stream)
            } else {
                let channel = FlutterEventChannel(
                    name: stream.name,
                    binaryMessenger: registrar.messenger(),
                    codec: FlutterJSONMethodCodec.sharedInstance()
                )
                
                channel.setStreamHandler(stream)

                channels[stream.type] = channel
            }
        }
    }
    
    func cleanup() {
        channels.values.forEach { channel in
            channel.setStreamHandler(nil)
        }
    }
    
    func emit(_ event: Event) {
        DispatchQueue.main.async { [weak self] in
            self?.streams[event.type]?.send(event)
        }
    }
}

// ActitoGeoPluginEvents.Stream
extension ActitoGeoPluginEvents {
    class Stream: NSObject, FlutterStreamHandler {
        let type: EventType
        let name: String

        private var eventSink: FlutterEventSink?
        private var pendingEvents: [Event] = []

        init(packageId: String, type: EventType) {
            self.type = type
            self.name = "\(packageId)/events/\(type.rawValue)"
        }

        func send(_ event: Event) {
            if let sink = self.eventSink {
                sink(event.payload)
            } else {
                pendingEvents.append(event)
            }
        }

        func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            self.eventSink = events

            if (self.eventSink != nil) {
                self.pendingEvents.forEach { send($0) }
                self.pendingEvents.removeAll()
            }

            return nil
        }

        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            self.eventSink = nil
            return nil
        }
    }
}

// ActitoGeoPluginEvents.Event
extension ActitoGeoPluginEvents {
    enum EventType: String, CaseIterable {
        case locationUpdated = "location_updated"
        case regionEntered = "region_entered"
        case regionExited = "region_exited"
        case beaconEntered = "beacon_entered"
        case beaconExited = "beacon_exited"
        case beaconsRanged = "beacons_ranged"
        case visit = "visit"
        case headingUpdated = "heading_updated"
    }
    
    struct Event {
        let type: EventType
        let payload: Any?
    }
}

extension ActitoGeoPluginEvents {
    static func OnLocationUpdated(location: ActitoLocation) -> Event {
        return Event(
            type: .locationUpdated,
            payload: try! location.toJson()
        )
    }
    
    static func OnRegionEntered(region: ActitoRegion) -> Event {
        return Event(
            type: .regionEntered,
            payload: try! region.toJson()
        )
    }
    
    static func OnRegionExited(region: ActitoRegion) -> Event {
        return Event(
            type: .regionExited,
            payload: try! region.toJson()
        )
    }
    
    static func OnBeaconEntered(beacon: ActitoBeacon) -> Event {
        return Event(
            type: .beaconEntered,
            payload: try! beacon.toJson()
        )
    }
    
    static func OnBeaconExited(beacon: ActitoBeacon) -> Event {
        return Event(
            type: .beaconExited,
            payload: try! beacon.toJson()
        )
    }
    
    static func OnBeaconsRanged(beacons: [ActitoBeacon], in region: ActitoRegion) -> Event {
        return Event(
            type: .beaconsRanged,
            payload: [
                "region": try! region.toJson(),
                "beacons": try! beacons.map { try $0.toJson() }
            ]
        )
    }
    
    static func OnVisit(visit: ActitoVisit) -> Event {
        return Event(
            type: .visit,
            payload: try! visit.toJson()
        )
    }
    
    static func OnHeadingUpdated(heading: ActitoHeading) -> Event {
        return Event(
            type: .headingUpdated,
            payload: try! heading.toJson()
        )
    }
}
