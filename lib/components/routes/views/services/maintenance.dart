// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/firebase/firestore.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaintenanceService extends StatefulWidget {
  static const String routname = '/maintenance';
  const MaintenanceService({super.key});

  @override
  State<MaintenanceService> createState() => _MaintenanceServiceState();
}

class _MaintenanceServiceState extends State<MaintenanceService> {
  //Mantenimiento
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController desmaController = TextEditingController();

  /*String _servicio = '';
  String _cliente = '';
  String _tipo = '';
  String _descripcion = '';
  String _tecnico = '';
  String _restecnico = '';
  String _etapa = '';
  String _tectotal = '';
  String _extras = '';
  String _total = '';
  String _fsolicitud = '';
  String _hsolicitud = '';
  String _frespuesta = '';
  String _hrespuesta = '';*/

  final _pref = PreferencesUser();

  String mantenimientoTag = 'mantenimientoTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarMantenimiento() async {
    LoadingScreen().show(context);

    final now = DateTime.now();
    final hsolicitud = DateFormat('HH:mm:ss').format(now);
    final fsolicitud = DateFormat('yyyy-MM-dd').format(now);

    if (tipeController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar la marca de su PC', context);
    } else if (desmaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente al daño de su PC', context);
    } else {
      FirebaseFirestore.instance.collection('Servicios').doc().set({
        'servicio': 'Mantenimiento',
        'cliente': _pref.ultimateUid,
        'tipo': tipeController.text,
        'descripcion': desmaController.text,
        'tecnico': '',
        'restecnico': '',
        'etapa': '',
        'tectotal': '',
        'extras': '',
        'total': '',
        'fsolicitud': hsolicitud,
        'hsolicitud': fsolicitud,
        'frespuesta': '',
        'hrespuesta': '',
      });

      LoadingScreen().hide();
    }
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
                    color: const Color(0xFF8894B2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      tipeController.clear();
                      desmaController.clear();
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
                      GuardarMantenimiento();
                      tipeController.clear();
                      desmaController.clear();
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
    final collections = GetCollectionsServices();

    return StreamBuilder<QuerySnapshot>(
      stream: collections.getCollections('Mantenimiento', _pref.ultimateUid),
      builder: (context, snapshot) {
        final service = snapshot.data?.docs;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        if (snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Center(child: Text('Mantenimiento')),
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
            floatingActionButton: FloatingActionButton(
              heroTag: mantenimientoTag,
              onPressed: () {
                new_Mantenimiento();
              },
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? WallpaperColor.danube().color
                  : WallpaperColor.baliHai().color,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
            body: const Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'No hay Datos',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Center(child: Text('Mantenimiento')),
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
          floatingActionButton: FloatingActionButton(
            heroTag: mantenimientoTag,
            onPressed: () {
              new_Mantenimiento();
            },
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? WallpaperColor.danube().color
                : WallpaperColor.baliHai().color,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: service?.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = service![index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            data['restecnico'] == ''
                                ? 'assets/ojo_cerrado.png'
                                : 'assets/ojo_abierto.png',
                            width: 50,
                            height: 50,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? WallpaperColor.black().color
                                    : WallpaperColor.white().color,
                            errorBuilder: (context, error, stackTrace) {
                              return IconButton(
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/user.png',
                                  width: 121.8,
                                  height: 121.8,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['tipo'] ?? '',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data['descripcion'] ?? '',
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 50,
                          tooltip: 'Add',
                          alignment: Alignment.center,
                        ),
                        const Text('Detalles')
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
