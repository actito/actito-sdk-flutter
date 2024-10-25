package com.actito.iam.flutter

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import com.actito.Actito
import com.actito.iam.ActitoInAppMessaging
import com.actito.iam.ktx.inAppMessaging
import com.actito.iam.models.ActitoInAppMessage

class ActitoInAppMessagingPlugin : FlutterPlugin, MethodChannel.MethodCallHandler,
    ActitoInAppMessaging.MessageLifecycleListener {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            binding.binaryMessenger,
            "com.actito.iam.flutter/actito_in_app_messaging",
            JSONMethodCodec.INSTANCE
        )
        channel.setMethodCallHandler(this)

        ActitoInAppMessagingPluginEventBroker.register(binding.binaryMessenger)
        Actito.inAppMessaging().addLifecycleListener(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Actito.inAppMessaging().removeLifecycleListener(this)

        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "hasMessagesSuppressed" -> hasMessagesSuppressed(call, result)
            "setMessagesSuppressed" -> setMessagesSuppressed(call, result)
            else -> result.notImplemented()
        }
    }

    private fun hasMessagesSuppressed(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: MethodChannel.Result) {
        result.success(Actito.inAppMessaging().hasMessagesSuppressed)
    }

    private fun setMessagesSuppressed(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: MethodChannel.Result) {
        val arguments = call.arguments<JSONObject>()
            ?: return result.error(ACTITO_ERROR, "Invalid request arguments.", null)

        val suppressed = arguments.getBoolean("suppressed")
        val evaluateContext =
            if (!arguments.isNull("evaluateContext")) {
                arguments.getBoolean("evaluateContext")
            } else {
                false
            }

        Actito.inAppMessaging().setMessagesSuppressed(suppressed, evaluateContext)

        result.success(null)
    }

    // region ActitoInAppMessaging.MessageLifecycleListener

    override fun onMessagePresented(message: ActitoInAppMessage) {
        ActitoInAppMessagingPluginEventBroker.emit(
            ActitoInAppMessagingPluginEventBroker.Event.MessagePresented(message)
        )
    }

    override fun onMessageFinishedPresenting(message: ActitoInAppMessage) {
        ActitoInAppMessagingPluginEventBroker.emit(
            ActitoInAppMessagingPluginEventBroker.Event.MessageFinishedPresenting(message)
        )
    }

    override fun onMessageFailedToPresent(message: ActitoInAppMessage) {
        ActitoInAppMessagingPluginEventBroker.emit(
            ActitoInAppMessagingPluginEventBroker.Event.MessageFailedToPresent(message)
        )
    }

    override fun onActionExecuted(message: ActitoInAppMessage, action: ActitoInAppMessage.Action) {
        ActitoInAppMessagingPluginEventBroker.emit(
            ActitoInAppMessagingPluginEventBroker.Event.ActionExecuted(message, action)
        )
    }

    override fun onActionFailedToExecute(
        message: ActitoInAppMessage,
        action: ActitoInAppMessage.Action,
        error: Exception?
    ) {
        ActitoInAppMessagingPluginEventBroker.emit(
            ActitoInAppMessagingPluginEventBroker.Event.ActionFailedToExecute(message, action, error)
        )
    }

    // endregion

    companion object {
        internal const val ACTITO_ERROR = "actito_error"
    }
}
