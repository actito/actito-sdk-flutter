import 'dart:io';

import 'package:flutter/material.dart';
import 'package:actito/actito.dart';
import 'package:actito_geo/actito_geo.dart';
import 'package:actito_in_app_messaging/actito_in_app_messaging.dart';
import 'package:actito_push/actito_push.dart';
import 'package:actito_push_ui/actito_push_ui.dart';
import 'package:flutter/services.dart';
import 'package:sample/ui/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger/custom_event_logger.dart';
import 'logger/logger.dart';

@pragma('vm:entry-point')
Future<void> _onLocationUpdatedCallback(ActitoLocation location) async {
  logger.i('onLocationUpdatedCallback');

  logCustomEvent("onLocationUpdatedCallback", location.toJson());
}

@pragma('vm:entry-point')
Future<void> _onRegionEnteredCallback(ActitoRegion region) async {
  logger.i('onRegionEnteredCallback');

  logCustomEvent("onRegionEnteredCallback", region.toJson());
}

@pragma('vm:entry-point')
Future<void> _onRegionExitedCallback(ActitoRegion region) async {
  logger.i('onRegionExitedCallback in app side');

  logCustomEvent("onRegionExitedCallback", region.toJson());
}

@pragma('vm:entry-point')
Future<void> _onBeaconEnteredCallback(ActitoBeacon beacon) async {
  logger.i('onBeaconEnteredCallback in app side');

  logCustomEvent("onBeaconEnteredCallback", beacon.toJson());
}

@pragma('vm:entry-point')
Future<void> _onBeaconExitedCallback(ActitoBeacon beacon) async {
  logger.i('onBeaconExitedCallback in app side');

  logCustomEvent("onBeaconExitedCallback", beacon.toJson());
}

@pragma('vm:entry-point')
Future<void> _onBeaconsRangedCallback(ActitoRangedBeaconsEvent event) async {
  logger.i('onBeaconsRangedCallback in app side');

  logCustomEvent("onBeaconsRangedCallback", event.toJson());
}

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _platform = MethodChannel('com.actito.sample/info');
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  bool get isIOSBackgroundEvent {
    final appState = WidgetsBinding.instance.lifecycleState;

    return Platform.isIOS &&
        (appState == AppLifecycleState.inactive ||
            appState == AppLifecycleState.detached);
  }

  @override
  void initState() {
    super.initState();

    _configureActito();
  }

  void _configureActito() async {
    final servicesInfo = await _platform.invokeMethod<Map>('getActitoServicesInfo');
    final applicationKey = servicesInfo?['applicationKey'];
    final applicationSecret = servicesInfo?['applicationSecret'];

    if (applicationKey == null || applicationSecret == null) {
      throw Exception("Failed to get services info.");
    }

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('applicationKey', applicationKey);
    sharedPreferences.setString('applicationSecret', applicationSecret);

    await ActitoGeo.setLocationUpdatedBackgroundCallback(
        _onLocationUpdatedCallback);
    await ActitoGeo.setRegionEnteredBackgroundCallback(
        _onRegionEnteredCallback);
    await ActitoGeo.setRegionExitedBackgroundCallback(_onRegionExitedCallback);
    await ActitoGeo.setBeaconEnteredBackgroundCallback(
        _onBeaconEnteredCallback);
    await ActitoGeo.setBeaconExitedBackgroundCallback(_onBeaconExitedCallback);
    await ActitoGeo.setBeaconsRangedBackgroundCallback(
        _onBeaconsRangedCallback);

    // region Actito events

    Actito.onReady.listen((application) async {
      logger.i('Actito onReady event.');
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Actito: ${application.name}'),
        ),
      );

      _handleDeferredLink();
    });

    Actito.onUnlaunched.listen((event) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Actito finished un-launching.'),
        ),
      );
    });

    Actito.onDeviceRegistered.listen((device) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Device registered: ${device.id}'),
        ),
      );
    });

    Actito.onUrlOpened.listen((url) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('URL opened: $url'),
        ),
      );
    });

    // endregion

    // region Actito Push events

    ActitoPush.onNotificationInfoReceived.listen((event) {
      logger.i(
          'Notification received (${event.deliveryMechanism}): ${event.notification.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Notification (${event.deliveryMechanism}) received.'),
        ),
      );
    });

    ActitoPush.onSystemNotificationReceived.listen((notification) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('System notification received.'),
        ),
      );
    });

    ActitoPush.onUnknownNotificationReceived.listen((notification) {
      logger.i('Unknown notification received: $notification');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Unknown notification received.'),
        ),
      );
    });

    ActitoPush.onNotificationOpened.listen((notification) async {
      await ActitoPushUI.presentNotification(notification);
    });

    ActitoPush.onUnknownNotificationOpened.listen((notification) {
      logger.i('Unknown notification opened: $notification');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Unknown notification opened.'),
        ),
      );
    });

    ActitoPush.onNotificationActionOpened.listen((data) async {
      await ActitoPushUI.presentAction(data.notification, data.action);
    });

    ActitoPush.onUnknownNotificationActionOpened.listen((data) {
      logger.i('Unknown notification action opened: $data');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Unknown notification action opened.'),
        ),
      );
    });

    ActitoPush.onNotificationSettingsChanged.listen((granted) {
      logger.i('Notification settings changed: $granted');

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Notification settings changed: $granted'),
        ),
      );
    });

    ActitoPush.onSubscriptionChanged.listen((subscription) {
      logger.i('Subscription changed: ${subscription?.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Subscription changed: ${subscription?.toJson()}'),
        ),
      );
    });

    // endregion

    // region Actito Push UI events

    ActitoPushUI.onNotificationWillPresent.listen((notification) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification will present.'),
        ),
      );
    });

    ActitoPushUI.onNotificationPresented.listen((notification) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification presented.'),
        ),
      );
    });

    ActitoPushUI.onNotificationFinishedPresenting.listen((notification) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification finished presenting.'),
        ),
      );
    });

    ActitoPushUI.onNotificationFailedToPresent.listen((notification) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification failed to present.'),
        ),
      );
    });

    ActitoPushUI.onNotificationUrlClicked.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Notification url clicked: ${data.url}'),
        ),
      );
    });

    ActitoPushUI.onActionWillExecute.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification action will execute.'),
        ),
      );
    });

    ActitoPushUI.onActionExecuted.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification action executed.'),
        ),
      );
    });

    ActitoPushUI.onActionNotExecuted.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification action not executed.'),
        ),
      );
    });

    ActitoPushUI.onActionFailedToExecute.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification action failed to execute.'),
        ),
      );
    });

    ActitoPushUI.onCustomActionReceived.listen((data) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Notification custom action received.'),
        ),
      );
    });

    // endregion

    // region Actito Geo events

    ActitoGeo.onLocationUpdated.listen((location) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onLocationUpdated", location.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Location updated: ${location.toJson()}'),
        ),
      );
    });

    ActitoGeo.onRegionEntered.listen((region) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onRegionEntered", region.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Region entered: ${region.name}'),
        ),
      );
    });

    ActitoGeo.onRegionExited.listen((region) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onRegionExited", region.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Region exited: ${region.name}'),
        ),
      );
    });

    ActitoGeo.onBeaconEntered.listen((beacon) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onBeaconEntered", beacon.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Beacon entered: ${beacon.name}'),
        ),
      );
    });

    ActitoGeo.onBeaconExited.listen((beacon) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onBeaconExited", beacon.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Beacon exited: ${beacon.name}'),
        ),
      );
    });

    ActitoGeo.onBeaconsRanged.listen((event) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onBeaconsRanged", event.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Beacons ranged: ${event.toJson()}'),
        ),
      );
    });

    ActitoGeo.onVisit.listen((visit) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onVisit", visit.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Visit: ${visit.toJson()}'),
        ),
      );
    });

    ActitoGeo.onHeadingUpdated.listen((heading) {
      if (isIOSBackgroundEvent) {
        logCustomEvent("onHeading", heading.toJson());
        return;
      }

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Heading updated: ${heading.toJson()}'),
        ),
      );
    });

    // endregion

    // region Actito In-App Messaging events

    ActitoInAppMessaging.onMessagePresented.listen((message) {
      logger.i('message presented = ${message.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('In-app message presented.'),
        ),
      );
    });

    ActitoInAppMessaging.onMessageFinishedPresenting.listen((message) {
      logger.i('message finished presenting = ${message.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('In-app message finished presenting.'),
        ),
      );
    });

    ActitoInAppMessaging.onMessageFailedToPresent.listen((message) {
      logger.i('message failed to present present = ${message.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('In-app message failed to present.'),
        ),
      );
    });

    ActitoInAppMessaging.onActionExecuted.listen((event) {
      logger.i('action executed = ${event.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('In-app message action executed.'),
        ),
      );
    });

    ActitoInAppMessaging.onActionFailedToExecute.listen((event) {
      logger.i('action failed to execute = ${event.toJson()}');

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('In-app message action failed to execute.'),
        ),
      );
    });

    // endregion

    try {
      await ActitoPush.setPresentationOptions([
        ActitoPresentationOptions.banner,
        ActitoPresentationOptions.badge,
        ActitoPresentationOptions.sound
      ]);

      await Actito.launch();
    } catch (error) {
      logger.e('Something went wrong.', error: error);
    }
  }

  void _handleDeferredLink() async {
    try {
      if (!await Actito.canEvaluateDeferredLink) {
        return;
      }

      final evaluated = await Actito.evaluateDeferredLink();
      logger.i('Did evaluate deferred link: $evaluated');

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Did evaluate deferred link: $evaluated'),
        ),
      );
    } catch (error) {
      logger.e('Error evaluating deferred link.', error: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const HomeView());
  }
}
