import 'package:computic/components/routes.dart';
import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/style/theme/dark.dart';
import 'package:computic/style/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Routes(),
      home: const Login(),
      //home: Home(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
