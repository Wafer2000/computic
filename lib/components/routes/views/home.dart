// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/firebase/firestore.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routname = 'Home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _textController = TextEditingController();

  Future<void> _signOut() async {
    var pref = PreferencesUserComputic();
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
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: false,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => {_signOut()}, icon: const Icon(Icons.logout)),
            const Expanded(child: Center(child: Text('Notes'))),
            const SizedBox(
              width: 48,
            )
          ],
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? WallpaperColor.steelBlue().color
            : WallpaperColor.kashmirBlue().color,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? IconColor.danube().color
            : IconColor.baliHai().color,
        child: const Icon(Icons.add),
      ),
    );
  }
}
