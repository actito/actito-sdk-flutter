package com.actito.push.flutter

import android.content.Context
import com.actito.models.ActitoNotification
import com.actito.push.ActitoPushIntentReceiver
import com.actito.push.models.ActitoNotificationDeliveryMechanism
import com.actito.push.models.ActitoSystemNotification
import com.actito.push.models.ActitoUnknownNotification

open class ActitoPushPluginReceiver : ActitoPushIntentReceiver() {

    override fun onNotificationReceived(
        context: Context,
        notification: ActitoNotification,
        deliveryMechanism: ActitoNotificationDeliveryMechanism
    ) {
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.NotificationInfoReceived(
                notification = notification,
                deliveryMechanism = deliveryMechanism
            )
        )
    }

    override fun onSystemNotificationReceived(context: Context, notification: ActitoSystemNotification) {
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.SystemNotificationReceived(
                notification = notification,
            )
        )
    }

    override fun onUnknownNotificationReceived(context: Context, notification: ActitoUnknownNotification) {
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.UnknownNotificationReceived(
                notification = notification,
            )
        )
    }

    override fun onNotificationOpened(context: Context, notification: ActitoNotification) {
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.NotificationOpened(
                notification = notification,
            )
        )
    }

    override fun onActionOpened(
        context: Context,
        notification: ActitoNotification,
        action: ActitoNotification.Action,
    ) {
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.NotificationActionOpened(
                notification = notification,
                action = action,
            )
        )
    }
}
