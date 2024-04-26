// ignore_for_file: unnecessary_null_comparison

import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/Log/register.dart';
import 'package:computic/components/routes/views/guard/extra_data.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/components/routes/views/profile.dart';
import 'package:computic/components/routes/views/services/creation.dart';
import 'package:computic/components/routes/views/services/facility.dart';
import 'package:computic/components/routes/views/services/maintenance.dart';
import 'package:computic/components/routes/views/services/rent.dart';
import 'package:computic/components/routes/views/services/shope.dart';
import 'package:computic/components/routes/views/services/training.dart';
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
  final prefs = PreferencesUser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routname,
      routes: {
        Home.routname: (context) => const Home(),
        Login.routname: (context) => const Login(),
        Profile.routname: (context) => const Profile(),
        Register.routname: (context) => const Register(),
        ExtraData.routname: (context) => const ExtraData(),
        SplashView.routname: (context) => const SplashView(),
        RentService.routname: (context) => const RentService(),
        ShopeService.routname: (context) => const ShopeService(),
        CreationService.routname: (context) => const CreationService(),
        FacilityService.routname: (context) => const FacilityService(),
        TrainingService.routname: (context) => const TrainingService(),
        MaintenanceService.routname: (context) => const MaintenanceService(),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}