import 'package:computic/firebase/firestore.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routname = 'Home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //Text Controller
  final TextEditingController _textController = TextEditingController();


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      backgroundColor: WallpaperColor.white().color,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: const CircleBorder(),
        backgroundColor: IconColor.veniceBlue().color,
        child: Icon(
          Icons.add,
          color: IconColor.iceberg().color,
        ),
      ),
    );
  }
}
