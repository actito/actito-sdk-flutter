//
//  ActitoEvent.swift
//  actito
//
//  Created by Helder Pinhal on 03/12/2020.
//

import Foundation
import ActitoKit

enum ActitoEventType: String, CaseIterable {
    case ready
    case unlaunched
    case deviceRegistered = "device_registered"
    case urlOpened = "url_opened"
}

protocol ActitoEvent {
    var type: ActitoEventType { get }
    var payload: Any? { get }
}

class ActitoEventOnReady: ActitoEvent {
    let type: ActitoEventType
    let payload: Any?

    init(application: ActitoApplication) {
        self.type = .ready
        self.payload = try! application.toJson()
    }
}

class ActitoEventOnUnlaunched: ActitoEvent {
    let type: ActitoEventType
    let payload: Any?

    init() {
        self.type = .unlaunched
        self.payload = nil
    }
}

class ActitoEventOnDeviceRegistered: ActitoEvent {
    let type: ActitoEventType
    let payload: Any?

    init(device: ActitoDevice) {
        self.type = .deviceRegistered
        self.payload = try! device.toJson()
    }
}

class ActitoEventOnUrlOpened: ActitoEvent {
    let type: ActitoEventType
    let payload: Any?

    init(url: String) {
        self.type = .urlOpened
        self.payload = url
    }
}
