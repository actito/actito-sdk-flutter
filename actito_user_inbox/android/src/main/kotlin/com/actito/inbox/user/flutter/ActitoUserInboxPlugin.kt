package com.actito.inbox.user.flutter

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import com.actito.Actito
import com.actito.ActitoCallback
import com.actito.inbox.user.ktx.userInbox
import com.actito.inbox.user.models.ActitoUserInboxItem
import com.actito.models.ActitoNotification

class ActitoUserInboxPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            binding.binaryMessenger,
            "com.actito.inbox.user.flutter/actito_user_inbox",
            JSONMethodCodec.INSTANCE
        )

        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "parseResponseFromJSON" -> parseResponseFromJSON(call, result)
            "parseResponseFromString" -> parseResponseFromString(call, result)
            "open" -> open(call, result)
            "markAsRead" -> markAsRead(call, result)
            "remove" -> remove(call, result)
            else -> result.notImplemented()
        }
    }

    private fun parseResponseFromJSON(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val json = call.arguments<JSONObject>() ?: return onMainThread {
            response.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val result = Actito.userInbox().parseResponse(json)

        onMainThread {
            response.success(result.toJson())
        }
    }

    private fun parseResponseFromString(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val json = call.arguments<String>() ?: return onMainThread {
            response.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val result = Actito.userInbox().parseResponse(json)

        onMainThread {
            response.success(result.toJson())
        }
    }

    private fun open(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val item = ActitoUserInboxItem.fromJson(arguments)

        Actito.userInbox().open(item, object : ActitoCallback<ActitoNotification> {
            override fun onSuccess(result: ActitoNotification) {
                onMainThread {
                    pluginResult.success(result.toJson())
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
                }
            }
        })
    }

    private fun markAsRead(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val item = ActitoUserInboxItem.fromJson(arguments)

        Actito.userInbox().markAsRead(item, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                pluginResult.success(null)
            }

            override fun onFailure(e: Exception) {
                pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    private fun remove(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val item = ActitoUserInboxItem.fromJson(arguments)

        Actito.userInbox().remove(item, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                pluginResult.success(null)
            }

            override fun onFailure(e: Exception) {
                pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    internal companion object {
        internal const val ACTITO_ERROR = "actito_error"

        internal fun onMainThread(action: () -> Unit) {
            Handler(Looper.getMainLooper()).post { action() }
        }
    }
}
