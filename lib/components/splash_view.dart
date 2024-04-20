// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, await_only_futures

import 'dart:async';
import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  static const String routname = 'SplashView';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    PreferencesUser prefs = PreferencesUser();
    Future.delayed(Duration(milliseconds: (6720).round()), () async {
      final uid = await prefs.ultimateUid;
      if (uid != null && uid != '') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Home();
          }),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Login();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WallpaperColor.white().color,
      body: Center(
        child: SizedBox(
          width: 120,
          height: 213.5,
          child: Lottie.asset('assets/troll_face.png'),
        ),
      ),
    );
  }
}