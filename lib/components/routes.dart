// ignore_for_file: unnecessary_null_comparison

import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/components/splash_view.dart';
import 'package:computic/shared/prefe_users.dart';
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
        Home.routname: (context) => const Home(),
      },
    );
  }
}