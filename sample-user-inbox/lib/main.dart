import 'package:flutter/material.dart';
import 'package:actito/actito.dart';
import 'package:actito_push/actito_push.dart';
import 'package:actito_push_ui/actito_push_ui.dart';
import 'package:sample_user_inbox/ui/home/home.dart';

import 'logger/logger.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    _configureActito();
  }

  void _configureActito() async {
    // region Actito events

    Actito.onReady.listen((application) async {
      logger.i('Actito onReady event.');
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Actito: ${application.name}'),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Sample User Inbox',
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
