//
//  ActitoPushUIPluginEventBroker.swift
//  actito_push_ui
//
//  Created by Helder Pinhal on 06/06/2021.
//

import ActitoKit
import ActitoPushUIKit

class ActitoPushUIPluginEventBroker {
    private let namespace: String
    
    private var channels: [EventType: FlutterEventChannel] = [:]
    private var streams: [EventType: Stream]
    
    init(namespace: String) {
        var streams: [EventType: Stream] = [:]
        EventType.allCases.forEach { type in
            streams[type] = Stream(namespace: namespace, type: type)
        }
        
        self.namespace = namespace
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

// ActitoPushUIPluginEventBroker.Stream
extension ActitoPushUIPluginEventBroker {
    class Stream: NSObject, FlutterStreamHandler {
        let type: EventType
        let name: String

        private var eventSink: FlutterEventSink?
        private var pendingEvents: [Event] = []

        init(namespace: String, type: EventType) {
            self.type = type
            self.name = "\(namespace)/events/\(type.rawValue)"
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

// ActitoPushUIPluginEventBroker.Event
extension ActitoPushUIPluginEventBroker {
    enum EventType: String, CaseIterable {
        case notificationWillPresent = "notification_will_present"
        case notificationPresented = "notification_presented"
        case notificationFinishedPresenting = "notification_finished_presenting"
        case notificationFailedToPresent = "notification_failed_to_present"
        case notificationUrlClicked = "notification_url_clicked"
        case actionWillExecute = "action_will_execute"
        case actionExecuted = "action_executed"
        case actionNotExecuted = "action_not_executed"
        case actionFailedToExecute = "action_failed_to_execute"
        case customActionReceived = "custom_action_received"
    }
    
    struct Event {
        let type: EventType
        let payload: Any?
    }
}

extension ActitoPushUIPluginEventBroker {
    static func OnNotificationWillPresent(notification: ActitoNotification) -> Event {
        return Event(
            type: .notificationWillPresent,
            payload: try! notification.toJson()
        )
    }
    
    static func OnNotificationPresented(notification: ActitoNotification) -> Event {
        return Event(
            type: .notificationPresented,
            payload: try! notification.toJson()
        )
    }
    
    static func OnNotificationFinishedPresenting(notification: ActitoNotification) -> Event {
        return Event(
            type: .notificationFinishedPresenting,
            payload: try! notification.toJson()
        )
    }
    
    static func OnNotificationFailedToPresent(notification: ActitoNotification) -> Event {
        return Event(
            type: .notificationFailedToPresent,
            payload: try! notification.toJson()
        )
    }
    
    static func OnNotificationUrlClicked(notification: ActitoNotification, url: URL) -> Event {
        return Event(
            type: .notificationUrlClicked,
            payload: [
                "notification": try! notification.toJson(),
                "url": url.absoluteString,
            ]
        )
    }
    
    static func OnActionWillExecute(notification: ActitoNotification, action: ActitoNotification.Action) -> Event {
        return Event(
            type: .actionWillExecute,
            payload: [
                "notification": try! notification.toJson(),
                "action": try! action.toJson(),
            ]
        )
    }
    
    static func OnActionExecuted(notification: ActitoNotification, action: ActitoNotification.Action) -> Event {
        return Event(
            type: .actionExecuted,
            payload: [
                "notification": try! notification.toJson(),
                "action": try! action.toJson(),
            ]
        )
    }
    
    static func OnActionNotExecuted(notification: ActitoNotification, action: ActitoNotification.Action) -> Event {
        return Event(
            type: .actionNotExecuted,
            payload: [
                "notification": try! notification.toJson(),
                "action": try! action.toJson(),
            ]
        )
    }
    
    static func OnActionFailedToExecute(notification: ActitoNotification, action: ActitoNotification.Action, error: Error?) -> Event {
        var payload: [String: Any] = [
            "notification": try! notification.toJson(),
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
    
    static func OnCustomActionReceived(notification: ActitoNotification, action: ActitoNotification.Action, url: URL) -> Event {
        return Event(
            type: .customActionReceived,
            payload: [
                "notification": try! notification.toJson(),
                "action": try! action.toJson(),
                "uri": url.absoluteString,
            ]
        )
    }
}
