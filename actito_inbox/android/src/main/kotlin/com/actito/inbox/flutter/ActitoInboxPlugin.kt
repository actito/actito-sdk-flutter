package com.actito.inbox.flutter

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.lifecycle.Observer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import com.actito.Actito
import com.actito.ActitoCallback
import com.actito.inbox.flutter.events.ActitoEvent
import com.actito.inbox.flutter.events.ActitoEventManager
import com.actito.inbox.ktx.inbox
import com.actito.inbox.models.ActitoInboxItem
import com.actito.models.ActitoNotification
import java.util.*

class ActitoInboxPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    private val itemsObserver = Observer<SortedSet<ActitoInboxItem>> { items ->
        if (items == null) return@Observer

        ActitoEventManager.send(
            ActitoEvent.InboxUpdated(items)
        )
    }

    private val badgeObserver = Observer<Int> { badge ->
        if (badge == null) return@Observer

        ActitoEventManager.send(
            ActitoEvent.BadgeUpdated(badge)
        )
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        ActitoEventManager.register(binding.binaryMessenger)

        channel = MethodChannel(
            binding.binaryMessenger,
            "com.actito.inbox.flutter/actito_inbox",
            JSONMethodCodec.INSTANCE
        )
        channel.setMethodCallHandler(this)

        Actito.inbox().observableItems.observeForever(itemsObserver)
        Actito.inbox().observableBadge.observeForever(badgeObserver)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Actito.inbox().observableItems.removeObserver(itemsObserver)
        Actito.inbox().observableBadge.removeObserver(badgeObserver)

        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getItems" -> getItems(call, result)
            "getBadge" -> getBadge(call, result)
            "refresh" -> refresh(call, result)
            "open" -> open(call, result)
            "markAsRead" -> markAsRead(call, result)
            "markAllAsRead" -> markAllAsRead(call, result)
            "remove" -> remove(call, result)
            "clear" -> clear(call, result)
            else -> result.notImplemented()
        }
    }

    private fun getItems(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        onMainThread {
            result.success(
                Actito.inbox().items.map { it.toJson() }
            )
        }
    }

    private fun getBadge(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        onMainThread {
            result.success(Actito.inbox().badge)
        }
    }

    private fun refresh(@Suppress("UNUSED_PARAMETER") call: MethodCall, result: Result) {
        Actito.inbox().refresh()
        result.success(null)
    }

    private fun open(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(ACTITO_ERROR, "Invalid request arguments.", null)
        }

        val item = ActitoInboxItem.fromJson(arguments)

        Actito.inbox().open(item, object : ActitoCallback<ActitoNotification> {
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

        val item = ActitoInboxItem.fromJson(arguments)

        Actito.inbox().markAsRead(item, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                pluginResult.success(null)
            }

            override fun onFailure(e: Exception) {
                pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    private fun markAllAsRead(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        Actito.inbox().markAllAsRead(object : ActitoCallback<Unit> {
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

        val item = ActitoInboxItem.fromJson(arguments)

        Actito.inbox().remove(item, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                pluginResult.success(null)
            }

            override fun onFailure(e: Exception) {
                pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    private fun clear(@Suppress("UNUSED_PARAMETER") call: MethodCall, pluginResult: Result) {
        Actito.inbox().clear(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                pluginResult.success(null)
            }

            override fun onFailure(e: Exception) {
                pluginResult.error(ACTITO_ERROR, e.localizedMessage, null)
            }
        })
    }

    companion object {
        internal const val ACTITO_ERROR = "actito_error"

        internal fun onMainThread(action: () -> Unit) {
            Handler(Looper.getMainLooper()).post { action() }
        }
    }
}
