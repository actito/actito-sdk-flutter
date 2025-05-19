package com.actito.geo.flutter

import android.content.Context
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
import com.actito.geo.flutter.ActitoGeoPluginBackgroundService.BackgroundEvent.CallbackType
import com.actito.geo.flutter.ActitoGeoPluginBackgroundService.Companion.isAttachedToActivity
import com.actito.geo.flutter.storage.ActitoGeoPluginStorage.updateCallback
import com.actito.geo.ktx.geo

class ActitoGeoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    internal companion object {
        private const val ACTITO_ERROR = "actito_error"
    }

    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "com.actito.geo.flutter/actito_geo",
            JSONMethodCodec.INSTANCE
        )
        channel.setMethodCallHandler(this)

        ActitoGeoPluginEventBroker.register(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = null
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "hasLocationServicesEnabled" -> hasLocationServicesEnabled(call, result)
            "hasBluetoothEnabled" -> hasBluetoothEnabled(call, result)
            "getMonitoredRegions" -> getMonitoredRegions(call, result)
            "getEnteredRegions" -> getEnteredRegions(call, result)
            "enableLocationUpdates" -> enableLocationUpdates(call, result)
            "disableLocationUpdates" -> disableLocationUpdates(call, result)

            // Background callback methods
            "setLocationUpdatedBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.LOCATION_UPDATED)

            "setRegionEnteredBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.REGION_ENTERED)

            "setRegionExitedBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.REGION_EXITED)

            "setBeaconEnteredBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.BEACON_ENTERED)

            "setBeaconExitedBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.BEACON_EXITED)

            "setBeaconsRangedBackgroundCallback" ->
                setBackgroundCallback(call, result, CallbackType.BEACONS_RANGED)

            else -> result.notImplemented()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        synchronized(isAttachedToActivity) {
            isAttachedToActivity.set(true)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {
        synchronized(isAttachedToActivity) {
            isAttachedToActivity.set(false)
        }
    }

    private fun hasLocationServicesEnabled(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        response.success(Actito.geo().hasLocationServicesEnabled)
    }

    private fun hasBluetoothEnabled(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        response.success(Actito.geo().hasBluetoothEnabled)
    }

    private fun getMonitoredRegions(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        response.success(
            Actito.geo().monitoredRegions.map { it.toJson() }
        )
    }

    private fun getEnteredRegions(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        response.success(
            Actito.geo().enteredRegions.map { it.toJson() }
        )
    }

    private fun enableLocationUpdates(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        Actito.geo().enableLocationUpdates()
        response.success(null)
    }

    private fun disableLocationUpdates(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: Result
    ) {
        Actito.geo().disableLocationUpdates()
        response.success(null)
    }

    private fun setBackgroundCallback(
        call: MethodCall,
        response: Result,
        callbackType: CallbackType
    ) {
        val arguments = call.arguments<JSONObject>()
            ?: return response.error(ACTITO_ERROR, "Invalid request arguments.", null)

        val callbackDispatcher = arguments.getLong("callbackDispatcher")
        val callback = arguments.getLong("callback")

        val context = applicationContext
            ?: return response.error(
                ACTITO_ERROR,
                "Unable to register background callback",
                null
            )

        context.updateCallback(
            callbackType = callbackType,
            callbackDispatcher = callbackDispatcher,
            callback = callback
        )

        response.success(null)
    }
}
