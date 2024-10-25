//
//  ActitoInAppMessagingPluginEvents.swift
//  actito_in_app_messaging
//
//  Created by Helder Pinhal on 13/09/2022.
//

import Foundation
import ActitoInAppMessagingKit

class ActitoInAppMessagingPluginEvents {
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

// ActitoInAppMessagingPluginEvents.Stream
extension ActitoInAppMessagingPluginEvents {
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

// ActitoInAppMessagingPluginEvents.Event
extension ActitoInAppMessagingPluginEvents {
    enum EventType: String, CaseIterable {
        case messagePresented = "message_presented"
        case messageFinishedPresenting = "message_finished_presenting"
        case messageFailedToPresent = "message_failed_to_present"
        case actionExecuted = "action_executed"
        case actionFailedToExecute = "action_failed_to_execute"
    }

    struct Event {
        let type: EventType
        let payload: Any?
    }
}

extension ActitoInAppMessagingPluginEvents {
    static func OnMessagePresented(message: ActitoInAppMessage) -> Event {
        return Event(
            type: .messagePresented,
            payload: try! message.toJson()
        )
    }

    static func OnMessageFinishedPresenting(message: ActitoInAppMessage) -> Event {
        return Event(
            type: .messageFinishedPresenting,
            payload: try! message.toJson()
        )
    }

    static func OnMessageFailedToPresent(message: ActitoInAppMessage) -> Event {
        return Event(
            type: .messageFailedToPresent,
            payload: try! message.toJson()
        )
    }

    static func OnActionExecuted(message: ActitoInAppMessage, action: ActitoInAppMessage.Action) -> Event {
        return Event(
            type: .actionExecuted,
            payload: [
                "message": try! message.toJson(),
                "action": try! action.toJson(),
            ]
        )
    }

    static func OnActionFailedToExecute(message: ActitoInAppMessage, action: ActitoInAppMessage.Action, error: Error?) -> Event {
        var payload: [String: Any] = [
            "message": try! message.toJson(),
            "action": try! action.toJson(),
        ]

        if let error = error {
            payload["error"] = error.localizedDescription
        }

        return Event(
            type: .actionFailedToExecute,
            payload: payload
        )
    }
}
