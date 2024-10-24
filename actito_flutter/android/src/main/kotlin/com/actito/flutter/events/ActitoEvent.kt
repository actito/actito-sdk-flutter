package com.actito.flutter.events

import com.actito.models.ActitoApplication
import com.actito.models.ActitoDevice

internal sealed class ActitoEvent {

    abstract val type: Type
    abstract val payload: Any?

    enum class Type(val id: String) {
        READY(id = "ready"),
        UNLAUNCHED(id = "unlaunched"),
        DEVICE_REGISTERED(id = "device_registered"),
        URL_OPENED(id = "url_opened"),
    }

    class Ready(
        application: ActitoApplication
    ) : ActitoEvent() {
        override val type = Type.READY
        override val payload = application.toJson()
    }

    class Unlaunched : ActitoEvent() {
        override val type = Type.UNLAUNCHED
        override val payload: Nothing? = null
    }

    class DeviceRegistered(
        device: ActitoDevice
    ) : ActitoEvent() {
        override val type = Type.DEVICE_REGISTERED
        override val payload = device.toJson()
    }

    class UrlOpened(
        url: String,
    ) : ActitoEvent() {
        override val type = Type.URL_OPENED
        override val payload = url
    }
}
