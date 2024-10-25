package com.actito.push.ui.flutter

import android.app.Activity
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import com.actito.Actito
import com.actito.models.ActitoNotification
import com.actito.push.ui.ActitoPushUI
import com.actito.push.ui.ktx.pushUI

public class ActitoPushUIPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    ActitoPushUI.NotificationLifecycleListener {

    public companion object {
        internal const val NAMESPACE = "com.actito.push.ui.flutter"
        private const val ACTITO_ERROR = "actito_error"
    }

    private var activity: Activity? = null

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "$NAMESPACE/actito_push_ui", JSONMethodCodec.INSTANCE)
        channel.setMethodCallHandler(this)

        logger.hasDebugLoggingEnabled = Actito.options?.debugLoggingEnabled ?: false

        ActitoPushUIPluginEventBroker.register(binding.binaryMessenger)

        Actito.pushUI().addLifecycleListener(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "presentNotification" -> presentNotification(call, result)
            "presentAction" -> presentAction(call, result)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        Actito.pushUI().removeLifecycleListener(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivityForConfigChanges() {}

    private fun presentNotification(call: MethodCall, result: Result) {
        val activity = activity ?: run {
            logger.warning("Flutter attached activity was null. Cannot continue.")
            result.error(ACTITO_ERROR, "Method called before an activity was attached.", null)
            return
        }

        val arguments = call.arguments<JSONObject>()
            ?: return result.error(ACTITO_ERROR, "Invalid request arguments.", null)

        val notification = ActitoNotification.fromJson(arguments)

        Actito.pushUI().presentNotification(activity, notification)
        result.success(null)
    }

    private fun presentAction(call: MethodCall, result: Result) {
        val activity = activity ?: run {
            logger.warning("Flutter attached activity was null. Cannot continue.")
            result.error(ACTITO_ERROR, "Method called before an activity was attached.", null)
            return
        }

        val json: JSONObject = call.arguments()
            ?: return result.error(ACTITO_ERROR, "Invalid request arguments.", null)

        val notification = ActitoNotification.fromJson(json.getJSONObject("notification"))
        val action = ActitoNotification.Action.fromJson(json.getJSONObject("action"))

        Actito.pushUI().presentAction(activity, notification, action)
        result.success(null)
    }

    // region ActitoPushUI.NotificationLifecycleListener

    override fun onNotificationWillPresent(notification: ActitoNotification) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.NotificationWillPresent(
                notification = notification,
            )
        )
    }

    override fun onNotificationPresented(notification: ActitoNotification) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.NotificationPresented(
                notification = notification,
            )
        )
    }

    override fun onNotificationFinishedPresenting(notification: ActitoNotification) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.NotificationFinishedPresenting(
                notification = notification,
            )
        )
    }

    override fun onNotificationFailedToPresent(notification: ActitoNotification) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.NotificationFailedToPresent(
                notification = notification,
            )
        )
    }

    override fun onNotificationUrlClicked(notification: ActitoNotification, uri: Uri) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.NotificationUrlClicked(
                notification = notification,
                uri = uri,
            )
        )
    }

    override fun onActionWillExecute(notification: ActitoNotification, action: ActitoNotification.Action) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.ActionWillExecute(
                notification = notification,
                action = action,
            )
        )
    }

    override fun onActionExecuted(notification: ActitoNotification, action: ActitoNotification.Action) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.ActionExecuted(
                notification = notification,
                action = action,
            )
        )
    }

    override fun onActionFailedToExecute(
        notification: ActitoNotification,
        action: ActitoNotification.Action,
        error: Exception?
    ) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.ActionFailedToExecute(
                notification = notification,
                action = action,
                error = error,
            )
        )
    }

    override fun onCustomActionReceived(
        notification: ActitoNotification,
        action: ActitoNotification.Action,
        uri: Uri
    ) {
        ActitoPushUIPluginEventBroker.emit(
            ActitoPushUIPluginEventBroker.Event.CustomActionReceived(
                notification = notification,
                action = action,
                uri = uri,
            )
        )
    }

    // endregion
}
