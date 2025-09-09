//
//  ActitoEventManager.swift
//  actito
//
//  Created by Helder Pinhal on 03/12/2020.
//

import Foundation
import Flutter

class ActitoEventManager {

    static let shared = ActitoEventManager()

    private var channels: [ActitoEventType: FlutterEventChannel] = [:]
    private var streams: [ActitoEventType: ActitoEventStream]

    private init() {
        var streams: [ActitoEventType: ActitoEventStream] = [:]

        ActitoEventType.allCases.forEach { type in
            streams[type] = ActitoEventStream(eventType: type)
        }

        self.streams = streams
    }

    func register(for registrar: FlutterPluginRegistrar) {
        streams.values.forEach { stream in
            if let channel = channels[stream.eventType] {
                channel.setStreamHandler(stream)
            } else {
                let channel = FlutterEventChannel(name: stream.name, binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec.sharedInstance())
                channel.setStreamHandler(stream)

                channels[stream.eventType] = channel
            }
        }
    }

    func unregister(for registrar: FlutterPluginRegistrar) {
        channels.values.forEach { channel in
            channel.setStreamHandler(nil)
        }
    }

    func send(_ event: ActitoEvent) {
        DispatchQueue.main.async { [weak self] in
            self?.streams[event.type]?.send(event)
        }
    }
}
