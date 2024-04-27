import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class FacilityService extends StatefulWidget {
  static const String routname = '/facility';
  const FacilityService({super.key});

  @override
  State<FacilityService> createState() => _FacilityServiceState();
}

class _FacilityServiceState extends State<FacilityService> {
  //instalacion de seguridad
  final TextEditingController desseController = TextEditingController();

  final _pref = PreferencesUser();

  String instalacionTag = 'instalacionTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarInstalacion() async {
    LoadingScreen().show(context);

    if (desseController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a la instalacion del servicio de seguridad',
          context);
    } else {
      FirebaseFirestore.instance
          .collection('Instalaciones')
          .doc()
          .set({
        'cliente': _pref.ultimateUid,
        'descripcion': desseController.text,
        'tecnico': '',
        'restecnico': '',
        'etapa': '',
        'tectotal': '',
        'extras': '',
        'total': '',
      });
      LoadingScreen().hide();
    }
  }

  void new_Instalacion() {
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
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    labelText:
                        'Decripcion de la instalacion de seguridad que necesita',
                    obscureText: false,
                    controller: desseController,
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
                    color: const Color(0xFF8894B2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07529B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GuardarInstalacion();
                      desseController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Solicitar',
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
        title: const Center(child: Text('Instalacion')),
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
                heroTag: instalacionTag,
                onPressed: () {
                  new_Instalacion();
                },
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.danube().color
                        : WallpaperColor.baliHai().color,
                child: const Text('Nueva Instalacion'),
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
