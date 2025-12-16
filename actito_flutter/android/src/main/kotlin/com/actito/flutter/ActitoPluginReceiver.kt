package com.actito.flutter

import android.content.Context
import com.actito.ActitoIntentReceiver
import com.actito.flutter.events.ActitoEvent
import com.actito.flutter.events.ActitoEventManager
import com.actito.models.ActitoApplication
import com.actito.models.ActitoDevice

open class ActitoPluginReceiver : ActitoIntentReceiver() {

    override fun onDeviceRegistered(context: Context, device: ActitoDevice) {
        ActitoEventManager.send(
            ActitoEvent.DeviceRegistered(device)
        )
    }

    override fun onReady(context: Context, application: ActitoApplication) {
        ActitoEventManager.send(
            ActitoEvent.Ready(application)
        )
    }

    override fun onUnlaunched(context: Context) {
        ActitoEventManager.send(
            ActitoEvent.Unlaunched()
        )
    }
}
