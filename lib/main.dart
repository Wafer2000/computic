import 'package:computic/components/routes.dart';
import 'package:computic/components/routes/tools/bloc/notifications_bloc.dart';
import 'package:computic/components/routes/tools/localNotification/local_notification.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/theme/dark.dart';
import 'package:computic/style/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesUser.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await LocalNotification.initializeLocalNotifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await Future.delayed(Duration(milliseconds: (6720).round()));
    FlutterNativeSplash.remove();
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationsBloc(),
        ),
      ],
      child: const App(),
    ));
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Routes(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
