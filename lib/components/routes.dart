// ignore_for_file: unnecessary_null_comparison

import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/Log/register.dart';
import 'package:computic/components/routes/views/guard/extra_data.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/components/routes/views/profile.dart';
import 'package:computic/components/splash_view.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/theme/dark.dart';
import 'package:computic/style/theme/light.dart';
import 'package:flutter/material.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final prefs = PreferencesUserComputic();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routname,
      routes: {
        SplashView.routname: (context) => const SplashView(),
        Login.routname: (context) => const Login(),
        Register.routname: (context) => const Register(),
        Home.routname: (context) => const Home(),
        Profile.routname: (context) => const Profile(),
        ExtraData.routname: (context) => const ExtraData(),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}