import 'package:computic/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUserComputic {
  static late SharedPreferences _prefs;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _prefs = await SharedPreferences.getInstance();
  }

  String get ultimateUid {
    return _prefs.getString('ultimateUid') ?? '';
  }

  set ultimateUid(String value) {
    _prefs.setString('ultimateUid', value);
  }

  String get description {
    return _prefs.getString('description') ?? '';
  }

  set description(String value) {
    _prefs.setString('description', value);
  }
}