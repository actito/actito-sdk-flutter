package com.actito.flutter.events

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.JSONMethodCodec

internal object ActitoEventManager {

    private val streams: Map<ActitoEvent.Type, ActitoEventStream> by lazy {
        ActitoEvent.Type.values().associate {
            it to ActitoEventStream(it)
        }
    }

    fun register(messenger: BinaryMessenger) {
        streams.values.forEach {
            val channel = EventChannel(messenger, it.name, JSONMethodCodec.INSTANCE)
            channel.setStreamHandler(it)
        }
    }

    fun send(event: ActitoEvent) {
        Handler(Looper.getMainLooper()).post {
            streams[event.type]?.emit(event)
        }
    }
}
