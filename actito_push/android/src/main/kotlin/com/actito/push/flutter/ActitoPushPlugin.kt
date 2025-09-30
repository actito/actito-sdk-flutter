package com.actito.push.flutter

import android.content.Intent
import androidx.annotation.NonNull
import androidx.lifecycle.Observer
import com.actito.Actito
import com.actito.ActitoCallback
import com.actito.push.ActitoPushIntentReceiver
import com.actito.push.ktx.push
import com.actito.push.models.ActitoPushSubscription
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class ActitoPushPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener {

    companion object {
        internal const val NAMESPACE = "com.actito.push.flutter"
        internal const val DEFAULT_ERROR_CODE = "actito_error"
    }

    private lateinit var channel: MethodChannel

    private val allowedUIObserver = Observer<Boolean> { allowedUI ->
        if (allowedUI == null) return@Observer

        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.NotificationSettingsChanged(
                allowedUI = allowedUI,
            )
        )
    }

    private val subscriptionObserver = Observer<ActitoPushSubscription?> { subscription ->
        ActitoPushPluginEventBroker.emit(
            ActitoPushPluginEventBroker.Event.SubscriptionChanged(
                subscription = subscription,
            )
        )
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        if (Actito.push().intentReceiver == ActitoPushIntentReceiver::class.java) {
            Actito.push().intentReceiver = ActitoPushPluginReceiver::class.java
        }

        channel = MethodChannel(binding.binaryMessenger, "$NAMESPACE/actito_push", JSONMethodCodec.INSTANCE)
        channel.setMethodCallHandler(this)

        ActitoPushPluginEventBroker.register(binding.binaryMessenger)

        Actito.push().observableAllowedUI.observeForever(allowedUIObserver)
        Actito.push().observableSubscription.observeForever(subscriptionObserver)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Actito.push().observableAllowedUI.removeObserver(allowedUIObserver)
        Actito.push().observableSubscription.removeObserver(subscriptionObserver)

        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "hasRemoteNotificationsEnabled" -> hasRemoteNotificationsEnabled(call, result)
            "allowedUI" -> allowedUI(call, result)
            "getTransport" -> getTransport(call, result)
            "getSubscription" -> getSubscription(call, result)
            "enableRemoteNotifications" -> enableRemoteNotifications(call, result)
            "disableRemoteNotifications" -> disableRemoteNotifications(call, result)
            else -> result.notImplemented()
        }
    }

    // region ActivityAware

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)

        val intent = binding.activity.intent
        if (intent != null) onNewIntent(intent)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}

    // endregion

    // region PluginRegistry.NewIntentListener

    override fun onNewIntent(intent: Intent): Boolean {
        return Actito.push().handleTrampolineIntent(intent)
    }

    // endregion

    private fun hasRemoteNotificationsEnabled(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        result.success(Actito.push().hasRemoteNotificationsEnabled)
    }

    private fun getTransport(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        result.success(Actito.push().transport?.rawValue)
    }

    private fun getSubscription(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        result.success(Actito.push().subscription?.toJson())
    }

    private fun allowedUI(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        result.success(Actito.push().allowedUI)
    }

    private fun enableRemoteNotifications(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        Actito.push().enableRemoteNotifications(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                response.success(null)
            }

            override fun onFailure(e: Exception) {
                response.error(DEFAULT_ERROR_CODE, e.message, null)
            }
        })
    }

    private fun disableRemoteNotifications(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        Actito.push().disableRemoteNotifications(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                response.success(null)
            }

            override fun onFailure(e: Exception) {
                response.error(DEFAULT_ERROR_CODE, e.message, null)
            }
        })
    }
}
