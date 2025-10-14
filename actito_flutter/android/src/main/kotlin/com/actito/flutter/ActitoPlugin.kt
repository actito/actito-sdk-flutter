package com.actito.flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import com.actito.Actito
import com.actito.ActitoCallback
import com.actito.ActitoEventData
import com.actito.ActitoIntentReceiver
import com.actito.flutter.events.ActitoEvent
import com.actito.flutter.events.ActitoEventManager
import com.actito.internal.ktx.toEventData
import com.actito.ktx.device
import com.actito.ktx.events
import com.actito.models.ActitoApplication
import com.actito.models.ActitoDoNotDisturb
import com.actito.models.ActitoDynamicLink
import com.actito.models.ActitoNotification
import com.actito.models.ActitoUserData
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONArray
import org.json.JSONObject

class ActitoPlugin : FlutterPlugin, ActivityAware, PluginRegistry.NewIntentListener {

    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        // Events
        ActitoEventManager.register(binding.binaryMessenger)

        if (Actito.intentReceiver == ActitoIntentReceiver::class.java) {
            Actito.intentReceiver = ActitoPluginReceiver::class.java
        }

        channel = MethodChannel(binding.binaryMessenger, "com.actito.flutter/actito", JSONMethodCodec.INSTANCE)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                // Actito
                "isConfigured" -> isConfigured(result)
                "isReady" -> isReady(result)
                "launch" -> launch(result)
                "unlaunch" -> unlaunch(result)
                "getApplication" -> getApplication(call, result)
                "fetchApplication" -> fetchApplication(call, result)
                "fetchNotification" -> fetchNotification(call, result)
                "fetchDynamicLink" -> fetchDynamicLink(call, result)
                "canEvaluateDeferredLink" -> canEvaluateDeferredLink(call, result)
                "evaluateDeferredLink" -> evaluateDeferredLink(call, result)

                // Device module
                "getCurrentDevice" -> getCurrentDevice(result)
                "register" -> register(call, result)
                "updateUser" -> updateUser(call, result)
                "fetchTags" -> fetchTags(result)
                "addTag" -> addTag(call, result)
                "addTags" -> addTags(call, result)
                "removeTag" -> removeTag(call, result)
                "removeTags" -> removeTags(call, result)
                "clearTags" -> clearTags(result)
                "getPreferredLanguage" -> getPreferredLanguage(result)
                "updatePreferredLanguage" -> updatePreferredLanguage(call, result)
                "fetchDoNotDisturb" -> fetchDoNotDisturb(result)
                "updateDoNotDisturb" -> updateDoNotDisturb(call, result)
                "clearDoNotDisturb" -> clearDoNotDisturb(result)
                "fetchUserData" -> fetchUserData(result)
                "updateUserData" -> updateUserData(call, result)

                // Events module
                "logCustom" -> logCustom(call, result)

                // Unhandled
                else -> result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // region ActivityAware

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        // Keep a reference to the current activity.
        activity = binding.activity

        // Listen to incoming intents.
        binding.addOnNewIntentListener(this)

        // Handle the initial intent, if any.
        val intent = binding.activity.intent
        if (intent != null) onNewIntent(intent)
    }

    override fun onDetachedFromActivity() {}

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    // endregion

    // region PluginRegistry.NewIntentListener

    override fun onNewIntent(intent: Intent): Boolean {
        // Try handling the test device intent.
        if (Actito.handleTestDeviceIntent(intent)) return true

        // Try handling the dynamic link intent.
        if (Actito.handleDynamicLinkIntent(activity, intent)) return true

        val url = intent.data?.toString()
        if (url != null) {
            ActitoEventManager.send(
                ActitoEvent.UrlOpened(url)
            )
        }

        return false
    }

    // endregion

    // region Actito

    private fun isConfigured(result: Result) {
        result.success(Actito.isConfigured)
    }

    private fun isReady(result: Result) {
        result.success(Actito.isReady)
    }

    private fun launch(response: Result) {
        Actito.launch(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                response.success(null)
            }

            override fun onFailure(e: Exception) {
                response.error(DEFAULT_ERROR_CODE, e.message, null)
            }
        })
    }

    private fun unlaunch(response: Result) {
        Actito.unlaunch(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                response.success(null)
            }

            override fun onFailure(e: Exception) {
                response.error(DEFAULT_ERROR_CODE, e.message, null)
            }
        })
    }

    private fun getApplication(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        response.success(Actito.application?.toJson())
    }

    private fun fetchApplication(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        Actito.fetchApplication(object : ActitoCallback<ActitoApplication> {
            override fun onSuccess(result: ActitoApplication) {
                onMainThread {
                    response.success(result.toJson())
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun fetchNotification(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        val id = call.arguments<String>() ?: return onMainThread {
            response.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        Actito.fetchNotification(id, object : ActitoCallback<ActitoNotification> {
            override fun onSuccess(result: ActitoNotification) {
                onMainThread {
                    response.success(result.toJson())
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun fetchDynamicLink(call: MethodCall, response: Result) {
        val url = call.arguments<String>() ?: return onMainThread {
            response.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val uri = Uri.parse(url)

        Actito.fetchDynamicLink(uri, object : ActitoCallback<ActitoDynamicLink> {
            override fun onSuccess(result: ActitoDynamicLink) {
                onMainThread {
                    response.success(result.toJson())
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun canEvaluateDeferredLink(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        Actito.canEvaluateDeferredLink(object : ActitoCallback<Boolean> {
            override fun onSuccess(result: Boolean) {
                onMainThread {
                    response.success(result)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun evaluateDeferredLink(@Suppress("UNUSED_PARAMETER") call: MethodCall, response: Result) {
        Actito.evaluateDeferredLink(object : ActitoCallback<Boolean> {
            override fun onSuccess(result: Boolean) {
                onMainThread {
                    response.success(result)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    // endregion

    // region Actito Device Manager

    private fun getCurrentDevice(pluginResult: Result) {
        pluginResult.success(Actito.device().currentDevice?.toJson())
    }

    private fun register(call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val userId = if (!arguments.isNull("userId")) arguments.getString("userId") else null
        val userName = if (!arguments.isNull("userName")) arguments.getString("userName") else null

        Actito.device().register(userId, userName, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun updateUser(call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val userId = if (!arguments.isNull("userId")) arguments.getString("userId") else null
        val userName = if (!arguments.isNull("userName")) arguments.getString("userName") else null

        Actito.device().updateUser(userId, userName, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun fetchTags(pluginResult: Result) {
        Actito.device().fetchTags(object : ActitoCallback<List<String>> {
            override fun onSuccess(result: List<String>) {
                onMainThread {
                    pluginResult.success(result)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun addTag(call: MethodCall, pluginResult: Result) {
        val tag = call.arguments<String>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        Actito.device().addTag(tag, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun addTags(call: MethodCall, pluginResult: Result) {
        val json = call.arguments<JSONArray>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val tags = mutableListOf<String>()
        for (i in 0 until json.length()) {
            tags.add(json.getString(i))
        }

        Actito.device().addTags(tags, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun removeTag(call: MethodCall, pluginResult: Result) {
        val tag = call.arguments<String>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        Actito.device().removeTag(tag, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun removeTags(call: MethodCall, pluginResult: Result) {
        val json = call.arguments<JSONArray>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val tags = mutableListOf<String>()
        for (i in 0 until json.length()) {
            tags.add(json.getString(i))
        }

        Actito.device().removeTags(tags, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun clearTags(pluginResult: Result) {
        Actito.device().clearTags(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun getPreferredLanguage(result: Result) {
        result.success(Actito.device().preferredLanguage)
    }

    private fun updatePreferredLanguage(call: MethodCall, pluginResult: Result) {
        val language = call.arguments<String?>()

        Actito.device().updatePreferredLanguage(language, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun fetchDoNotDisturb(pluginResult: Result) {
        Actito.device().fetchDoNotDisturb(object : ActitoCallback<ActitoDoNotDisturb?> {
            override fun onSuccess(result: ActitoDoNotDisturb?) {
                onMainThread {
                    pluginResult.success(result?.toJson())
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun updateDoNotDisturb(call: MethodCall, pluginResult: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val dnd = ActitoDoNotDisturb.fromJson(arguments)

        Actito.device().updateDoNotDisturb(dnd, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun clearDoNotDisturb(pluginResult: Result) {
        Actito.device().clearDoNotDisturb(object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun fetchUserData(pluginResult: Result) {
        Actito.device().fetchUserData(object : ActitoCallback<ActitoUserData> {
            override fun onSuccess(result: ActitoUserData) {
                onMainThread {
                    pluginResult.success(result)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    private fun updateUserData(call: MethodCall, pluginResult: Result) {
        val json = call.arguments<JSONObject>() ?: return onMainThread {
            pluginResult.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val userData = mutableMapOf<String, String?>()

        val iterator = json.keys()
        while (iterator.hasNext()) {
            val key = iterator.next()
            userData[key] = if (json.isNull(key)) null else json.getString(key)
        }

        Actito.device().updateUserData(userData, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    pluginResult.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    pluginResult.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    // endregion

    // region Actito Events Manager

    private fun logCustom(call: MethodCall, response: Result) {
        val arguments = call.arguments<JSONObject>() ?: return onMainThread {
            response.error(DEFAULT_ERROR_CODE, "Invalid request arguments.", null)
        }

        val event: String
        val data: ActitoEventData?

        try {
            event = requireNotNull(arguments.getString("event"))
            data = if (!arguments.isNull("data")) {
                arguments.getJSONObject("data").toEventData()
            } else {
                null
            }
        } catch (e: Exception) {
            onMainThread {
                response.error(DEFAULT_ERROR_CODE, e.message, null)
            }

            return
        }

        Actito.events().logCustom(event, data, object : ActitoCallback<Unit> {
            override fun onSuccess(result: Unit) {
                onMainThread {
                    response.success(null)
                }
            }

            override fun onFailure(e: Exception) {
                onMainThread {
                    response.error(DEFAULT_ERROR_CODE, e.message, null)
                }
            }
        })
    }

    // endregion

    internal companion object {
        const val DEFAULT_ERROR_CODE = "actito_error"

        internal fun onMainThread(action: () -> Unit) {
            Handler(Looper.getMainLooper()).post { action() }
        }
    }
}
