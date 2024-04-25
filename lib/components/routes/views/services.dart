// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  static const String routname = '/services';
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  //creacion de paginas y apps
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descreaController = TextEditingController();

  //alquiler de video views
  final TextEditingController timeController = TextEditingController();
  final TextEditingController desalController = TextEditingController();

  //instalacion de seguridad
  final TextEditingController desseController = TextEditingController();

  //Capacitaciones
  final TextEditingController descaController = TextEditingController();

  //Mantenimiento
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController desmaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  final _pref = PreferencesUser();

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
          .collection('Maintences Creacion')
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
          .collection('Maintences')
          .doc(_pref.ultimateUid)
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

  void GuardarInstalacion() async {
    LoadingScreen().show(context);

    if (desseController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a la instalacion del servicio de seguridad',
          context);
    } else {
      FirebaseFirestore.instance
          .collection('Maintences')
          .doc(_pref.ultimateUid)
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

  void GuardarCapacitacion() async {
    LoadingScreen().show(context);

    if (descaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a lo que desea en la capacitacion',
          context);
    } else {
      FirebaseFirestore.instance
          .collection('Maintences')
          .doc(_pref.ultimateUid)
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

  void GuardarMantenimiento() async {
    LoadingScreen().show(context);

    if (tipeController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar la marca de su PC', context);
    } else if (desmaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente al daño de su PC', context);
    } else {
      FirebaseFirestore.instance
          .collection('Maintences')
          .doc(_pref.ultimateUid)
          .set({
        'cliente': _pref.ultimateUid,
        'tipo': tipeController.text,
        'descripcion': desmaController.text,
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
                    color: const Color(0xFF07529B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GuardarInstalacion();
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
                    color: const Color(0xFF07529B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      GuardarCapacitacion();
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

  void new_Mantenimiento() {
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
                    labelText: 'Tipo de computador',
                    obscureText: false,
                    controller: tipeController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    labelText: 'Decripcion del daño de su equipo',
                    obscureText: false,
                    controller: desmaController,
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
                      GuardarInstalacion();
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

  String creacionTag = 'creacionTag';
  String alquilerTag = 'alquilerTag';
  String instalacionTag = 'instalacionTag';
  String capacitacionTag = 'capacitacionTag';
  String mantenimientoTag = 'mantenimientoTag';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Servicios')),
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 10),
                  height: 55,
                  width: 65,
                  child: FloatingActionButton(
                    mini: true,
                    heroTag: creacionTag,
                    onPressed: () {
                      new_Creacion();
                    },
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? WallpaperColor.danube().color
                            : WallpaperColor.baliHai().color,
                    child: const Text('Creacion'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 10),
                  height: 55,
                  width: 65,
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
                    child: const Text('Alquiler'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 10),
                  height: 55,
                  width: 75,
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
                    child: const Text('Instalacion'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 10),
                  height: 55,
                  width: 85,
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
                    child: const Text('Capacitacion'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 10),
                  height: 55,
                  width: 95,
                  child: FloatingActionButton(
                    mini: true,
                    heroTag: mantenimientoTag,
                    onPressed: () {
                      new_Mantenimiento();
                    },
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? WallpaperColor.danube().color
                            : WallpaperColor.baliHai().color,
                    child: const Text('Mantenimiento'),
                  ),
                ),
              ],
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
