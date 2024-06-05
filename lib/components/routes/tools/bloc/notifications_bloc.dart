import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:computic/components/routes/tools/localNotification/local_notification.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var mensaje = message.data;
  var body = mensaje['boby'];
  var title = mensaje['title'];

  Random random = Random();
  var id = random.nextInt(100000);
  LocalNotification.showLocalNotification(
    id: id,
    title: title,
    body: body,
  );
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsInitial()) {
    _onForegroundMessage();
    /*on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });*/
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    await LocalNotification.requestPermissionLocalNotifications();

    settings.authorizationStatus;
    _getToken();
  }

  void _getToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    if (token != null) {
      final prefs = PreferencesUser();
      prefs.token = token;
    }
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    var mensaje = message.data;
    var body = mensaje['boby'];
    var title = mensaje['title'];

    Random random = Random();
    var id = random.nextInt(100000);
    LocalNotification.showLocalNotification(
      id: id,
      title: title,
      body: body,
    );
  }
}
