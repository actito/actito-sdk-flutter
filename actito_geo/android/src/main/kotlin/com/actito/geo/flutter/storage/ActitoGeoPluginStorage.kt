package com.actito.geo.flutter.storage

import android.content.Context
import com.actito.geo.flutter.ActitoGeoPluginBackgroundService

internal object ActitoGeoPluginStorage {
    private const val sharedPreferencesKey = "re.notifica.geo.flutter.callback_shared_preferences"
    private const val callbackDispatcherKey = "re.notifica.geo.flutter.callback_dispatcher"

    internal fun Context.getCallbackDispatcher(): Long {
        return getSharedPreferences(sharedPreferencesKey, Context.MODE_PRIVATE)
            .getLong(callbackDispatcherKey, 0)
    }

    internal fun Context.getCallback(callbackType: ActitoGeoPluginBackgroundService.BackgroundEvent.CallbackType): Long {
        return getSharedPreferences(sharedPreferencesKey, Context.MODE_PRIVATE)
            .getLong(callbackType.key, 0)
    }

    internal fun Context.updateCallback(
        callbackType: ActitoGeoPluginBackgroundService.BackgroundEvent.CallbackType,
        callbackDispatcher: Long,
        callback: Long
    ) {
        getSharedPreferences(sharedPreferencesKey, Context.MODE_PRIVATE)
            .edit()
            .putLong(callbackDispatcherKey, callbackDispatcher)
            .putLong(callbackType.key, callback)
            .apply()
    }
}
