// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/views/profile.dart';
import 'package:computic/components/routes/views/services/creation.dart';
import 'package:computic/components/routes/views/services/facility.dart';
import 'package:computic/components/routes/views/services/maintenance.dart';
import 'package:computic/components/routes/views/services/rent.dart';
import 'package:computic/components/routes/views/services/training.dart';
import 'package:computic/firebase/firestore.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _textController = TextEditingController();

  Future<void> _signOut() async {
    var pref = PreferencesUser();
    LoadingScreen().show(context);

    try {
      await FirebaseAuth.instance.signOut();
      pref.ultimateUid = '';
      LoadingScreen().hide();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? 'assets/14.png'
                      : 'assets/13.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.cloud,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        title: const Text('S E R V I C I O S'),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons
                                    .build, // MANTENIMIENTO (icono de herramienta)
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              title: const Text('M A N T E N I M I E N T O'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, MaintenanceService.routname);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.school, // CAPACITACIÓN (icono de escuela)
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              title: const Text('C A P A C I T A C I O N'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, TrainingService.routname);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons
                                    .home_repair_service, // INSTALACIÓN (icono de reparación en casa)
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              title: const Text('I N S T A L A C I O N'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, FacilityService.routname);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons
                                    .add_circle_outline, // INSTALACIÓN (icono de reparación en casa)
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              title: const Text('C R E A C I O N'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, CreationService.routname);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons
                                    .device_hub, // ALQUILER (icono de apartamento)
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              title: const Text('A L Q U I L A R'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, RentService.routname);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('P E R F I L E'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Profile.routname);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text('C E R R A R  S E S I O N'),
              onTap: () {
                _signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
