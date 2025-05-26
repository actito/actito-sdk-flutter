//
//  ActitoEventStream.swift
//  actito
//
//  Created by Helder Pinhal on 03/12/2020.
//

import Foundation

class ActitoEventStream: NSObject, FlutterStreamHandler {

    let eventType: ActitoEventType
    let name: String

    private var eventSink: FlutterEventSink?
    private var pendingEvents: [ActitoEvent] = []

    init(eventType: ActitoEventType) {
        self.eventType = eventType
        self.name = "com.actito.flutter/events/\(eventType.rawValue)"
    }

    func send(_ event: ActitoEvent) {
        if let sink = self.eventSink {
            sink(event.payload)
        } else {
            pendingEvents.append(event)
        }
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events

        if self.eventSink != nil {
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
