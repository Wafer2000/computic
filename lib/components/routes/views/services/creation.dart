import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class CreationService extends StatefulWidget {
  static const String routname = '/creation';
  const CreationService({super.key});

  @override
  State<CreationService> createState() => _CreationServiceState();
}

class _CreationServiceState extends State<CreationService> {
  //creacion de paginas y apps
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descreaController = TextEditingController();

  final _pref = PreferencesUser();

  String creacionTag = 'creacionTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarCreacion() async {
    LoadingScreen().show(context);

    if (nameController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar el nombre de su pagina web o aplicacion', context);
    } else if (descreaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a lo que desea', context);
    } else {
      FirebaseFirestore.instance
          .collection('Creaciones')
          .doc(_pref.ultimateUid)
          .set({
        'cliente': _pref.ultimateUid,
        'nombre': nameController.text,
        'descripcion': descreaController.text,
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

  void new_Creacion() {
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
                    labelText: 'Nombre de su pagina web o aplicacion',
                    obscureText: false,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    labelText: 'Decripcion de lo que necesita',
                    obscureText: false,
                    controller: descreaController,
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
                      GuardarCreacion();
                      nameController.clear();
                      descreaController.clear();
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
                      nameController.clear();
                      descreaController.clear();
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
        title: const Center(child: Text('Creacion')),
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
      body: const Text('Bienvenido a la tienda'),
    );
  }
}
