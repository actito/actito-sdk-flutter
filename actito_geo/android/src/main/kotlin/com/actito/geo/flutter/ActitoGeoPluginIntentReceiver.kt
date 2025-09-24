package com.actito.geo.flutter

import android.content.Context
import com.actito.geo.ActitoGeoIntentReceiver
import com.actito.geo.models.ActitoBeacon
import com.actito.geo.models.ActitoLocation
import com.actito.geo.models.ActitoRegion

public open class ActitoGeoPluginIntentReceiver : ActitoGeoIntentReceiver() {
    override fun onLocationUpdated(context: Context, location: ActitoLocation) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.LocationUpdated(context, location)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.LocationUpdated(location)
        )
    }

    override fun onRegionEntered(context: Context, region: ActitoRegion) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.RegionEntered(context, region)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.RegionEntered(region)
        )
    }

    override fun onRegionExited(context: Context, region: ActitoRegion) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.RegionExited(context, region)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.RegionExited(region)
        )
    }

    override fun onBeaconEntered(context: Context, beacon: ActitoBeacon) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.BeaconEntered(context, beacon)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.BeaconEntered(beacon)
        )
    }

    override fun onBeaconExited(context: Context, beacon: ActitoBeacon) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.BeaconExited(context, beacon)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.BeaconExited(beacon)
        )
    }

    override fun onBeaconsRanged(context: Context, region: ActitoRegion, beacons: List<ActitoBeacon>) {
        if (ActitoGeoPluginBackgroundService.shouldProcessAsBackgroundEvent()) {
            val event = ActitoGeoPluginBackgroundService.BackgroundEvent.BeaconsRanged(context, beacons, region)
            ActitoGeoPluginBackgroundService.processAsBackgroundEvent(context, event)

            return
        }

        ActitoGeoPluginEventBroker.emit(
            ActitoGeoPluginEventBroker.Event.BeaconsRanged(region, beacons)
        )
    }
}
