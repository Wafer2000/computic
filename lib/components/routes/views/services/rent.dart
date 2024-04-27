import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class RentService extends StatefulWidget {
  static const String routname = '/rent';
  const RentService({super.key});

  @override
  State<RentService> createState() => _RentServiceState();
}

class _RentServiceState extends State<RentService> {
  //alquiler de video views
  final TextEditingController timeController = TextEditingController();
  final TextEditingController desalController = TextEditingController();

  final _pref = PreferencesUser();

  String alquilerTag = 'alquilerTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarAlquiler() async {
    LoadingScreen().show(context);

    if (timeController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar la marca de su PC', context);
    } else if (desalController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente al daño de su PC', context);
    } else {
      FirebaseFirestore.instance
          .collection('Alquileres')
          .doc()
          .set({
        'cliente': _pref.ultimateUid,
        'tipo': timeController.text,
        'descripcion': desalController.text,
        'respuesta': '',
        'total': '',
      });
      LoadingScreen().hide();
    }
  }

  void new_Alquiler() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Llene todos los campos'),
          icon: const Icon(Icons.build),
          shadowColor: WallpaperColor.baliHai().color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    labelText: 'Tiempo del alquiler',
                    obscureText: false,
                    controller: timeController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    labelText: 'Decripcion para datos extras',
                    obscureText: false,
                    controller: desalController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? 'assets/14.png'
                            : 'assets/13.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07529B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GuardarAlquiler();
                      timeController.clear();
                      desalController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Solicitar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8894B2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      timeController.clear();
                      desalController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Alquiler')),
        actions: const [
          SizedBox(
            width: 48,
          )
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? WallpaperColor.steelBlue().color
            : WallpaperColor.kashmirBlue().color,
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                mini: true,
                heroTag: alquilerTag,
                onPressed: () {
                  new_Alquiler();
                },
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.danube().color
                        : WallpaperColor.baliHai().color,
                child: const Text('Nuevo Alquiler'),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Column(
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
