package com.actito.scannables.flutter

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.actito.Actito
import com.actito.ActitoCallback
import com.actito.scannables.ActitoScannables
import com.actito.scannables.ktx.scannables
import com.actito.scannables.models.ActitoScannable

class ActitoScannablesPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    ActitoScannables.ScannableSessionListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "com.actito.scannables.flutter/actito_scannables",
            JSONMethodCodec.INSTANCE
        )
        channel.setMethodCallHandler(this)

        ActitoScannablesPluginEventBroker.register(flutterPluginBinding.binaryMessenger)
        Actito.scannables().addListener(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)

        Actito.scannables().removeListener(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "canStartNfcScannableSession" -> canStartNfcScannableSession(call, result)
            "startScannableSession" -> startScannableSession(call, result)
            "startNfcScannableSession" -> startNfcScannableSession(call, result)
            "startQrCodeScannableSession" -> startQrCodeScannableSession(call, result)
            "fetch" -> fetch(call, result)
            else -> result.notImplemented()
        }
    }

    // region ActivityAware

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivityForConfigChanges() {}

    // endregion

    private fun canStartNfcScannableSession(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        response.success(Actito.scannables().canStartNfcScannableSession)
    }

    private fun startScannableSession(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val activity = activity ?: run {
            response.error(
                ACTITO_ERROR,
                "Unable to start a scannable session before an activity is available.",
                null
            )

            return
        }

        Actito.scannables().startScannableSession(activity)
        response.success(null)
    }

    private fun startNfcScannableSession(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val activity = activity ?: run {
            response.error(
                ACTITO_ERROR,
                "Unable to start a scannable session before an activity is available.",
                null
            )

            return
        }

        Actito.scannables().startNfcScannableSession(activity)
        response.success(null)
    }

    private fun startQrCodeScannableSession(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val activity = activity ?: run {
            response.error(
                ACTITO_ERROR,
                "Unable to start a scannable session before an activity is available.",
                null
            )

            return
        }

        Actito.scannables().startQrCodeScannableSession(activity)
        response.success(null)
    }

    private fun fetch(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val tag = call.arguments<String>()
            ?: return response.error(ACTITO_ERROR, "Invalid request arguments.", null)

        Actito.scannables().fetch(tag, object : ActitoCallback<ActitoScannable> {
            override fun onSuccess(result: ActitoScannable) {
                response.success(result.toJson())
            }

            override fun onFailure(e: Exception) {
                response.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    // region ActitoScannables.ScannableSessionListener

    override fun onScannableDetected(scannable: ActitoScannable) {
        ActitoScannablesPluginEventBroker.emit(
            ActitoScannablesPluginEventBroker.Event.ScannableDetected(scannable)
        )
    }

    override fun onScannableSessionError(error: Exception) {
        ActitoScannablesPluginEventBroker.emit(
            ActitoScannablesPluginEventBroker.Event.ScannableSessionFailed(error)
        )
    }

    // endregion

    internal companion object {
        internal const val ACTITO_ERROR = "actito_error"
    }
}
