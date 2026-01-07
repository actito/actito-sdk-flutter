package com.actito.sample

import android.content.res.Resources
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.actito.sample/info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getActitoServicesInfo" -> getActitoServicesInfo(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun getActitoServicesInfo(
        @Suppress("UNUSED_PARAMETER") call: MethodCall,
        response: MethodChannel.Result,
    ) {
        val applicationKey =
            try {
                getString(R.string.actito_services_application_key)
            } catch (_: Resources.NotFoundException) {
                error("Application secret resource unavailable.")
            }

        val applicationSecret =
            try {
                getString(R.string.actito_services_application_secret)
            } catch (_: Resources.NotFoundException) {
                error("Application secret resource unavailable.")
            }

        val data =
            mapOf(
                "applicationKey" to applicationKey,
                "applicationSecret" to applicationSecret,
            )

        response.success(data)
    }
}
