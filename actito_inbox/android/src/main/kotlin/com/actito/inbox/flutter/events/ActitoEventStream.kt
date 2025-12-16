package com.actito.inbox.flutter.events

import io.flutter.plugin.common.EventChannel

internal class ActitoEventStream(type: ActitoEvent.Type) : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null
    private val pendingEvents = mutableListOf<ActitoEvent>()

    val name = "com.actito.inbox.flutter/events/${type.id}"

    fun emit(event: ActitoEvent) {
        val eventSink = this.eventSink

        if (eventSink == null) {
            pendingEvents.add(event)
        } else {
            eventSink.success(event.payload)
        }
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink

        if (eventSink != null) {
            pendingEvents.forEach(::emit)
            pendingEvents.clear()
        }
    }

    override fun onCancel(arguments: Any?) {
        this.eventSink = null
    }
}
