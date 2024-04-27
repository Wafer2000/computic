import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class TrainingService extends StatefulWidget {
  static const String routname = '/training';
  const TrainingService({super.key});

  @override
  State<TrainingService> createState() => _TrainingServiceState();
}

class _TrainingServiceState extends State<TrainingService> {
  //Capacitaciones
  final TextEditingController descaController = TextEditingController();

  final _pref = PreferencesUser();

  String capacitacionTag = 'capacitacionTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarCapacitacion() async {
    LoadingScreen().show(context);

    if (descaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a lo que desea en la capacitacion',
          context);
    } else {
      FirebaseFirestore.instance
          .collection('Capacitaciones')
          .doc()
          .set({
        'cliente': _pref.ultimateUid,
        'descripcion': descaController.text,
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

  void new_Capacitacion() {
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
                    labelText: 'Decripcion de la capacitacion que necesita',
                    obscureText: false,
                    controller: descaController,
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
                      descaController.clear();
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
                      GuardarCapacitacion();
                      descaController.clear();
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
        title: const Center(child: Text('Capacitaciones')),
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
                heroTag: capacitacionTag,
                onPressed: () {
                  new_Capacitacion();
                },
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.danube().color
                        : WallpaperColor.baliHai().color,
                child: const Text('Nueva Capacitacion'),
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
