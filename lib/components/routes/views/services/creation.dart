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

  void GuardarCreacion(String direccion) async {
    LoadingScreen().show(context);

    final now = DateTime.now();
    final hsolicitud = DateFormat('HH:mm:ss').format(now);
    final fsolicitud = DateFormat('yyyy-MM-dd').format(now);

    if (nameController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar el nombre de su pagina web o aplicacion', context);
    } else if (descreaController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debe colocar una descripcion referente a lo que desea', context);
    } else if (direccion == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debes agregar una direccion de tu punta de asistencia', context);
    } else if (direccion != '') {
      FirebaseFirestore.instance.collection('Servicios').doc().set({
        'servicio': 'Creaciones',
        'cliente': _pref.ultimateUid,
        'nombre': nameController.text,
        'descripcion': descreaController.text,
        'tecnico': '',
        'idtecnico': '',
        'restecnico': '',
        'direccion': direccion,
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF07529B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final DocumentSnapshot client = await FirebaseFirestore
                          .instance
                          .collection('Users')
                          .doc(_pref.ultimateUid)
                          .get();

                      String direccion = client.get('direccion');

                      print('Direccion: $direccion');
                      GuardarCreacion(direccion);
                      nameController.clear();
                      descreaController.clear();
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

  void details_Creacion(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de su creacion'),
          icon: const Icon(Icons.code),
          shadowColor: WallpaperColor.baliHai().color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Servicios')
                  .doc(id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const AlertDialog(
                    title: Text('Algo salio mal'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                if (snapshot.data == null) {
                  return const Text('No hay datos');
                }
                final doc = snapshot.data!;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // Add this line
                              children: [
                                Text(
                                  'Nombre de su aplicacion o pagina web: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.left, // Add this line
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // Add this line
                              children: [
                                Flexible(
                                  child: Text(
                                    '${doc['nombre']}',
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // Add this line
                              children: [
                                Text(
                                  'Descripcion: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.left, // Add this line
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // Add this line
                              children: [
                                Flexible(
                                  child: Text(
                                    '${doc['descripcion']}',
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (doc['tecnico'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Text(
                                    'Tecnico Asignado: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ],
                              ),
                            ),
                          if (doc['tecnico'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['tecnico']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['tecnico'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['restecnico'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Text(
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnico'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['tecnico']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnico'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['etapa'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Text(
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ],
                              ),
                            ),
                          if (doc['etapa'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['etapa']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['etapa'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['total'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Text(
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ],
                              ),
                            ),
                          if (doc['total'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Add this line
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['total']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['total'] != '')
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
                          Divider(
                            height: 10, // The height of the divider
                            thickness: 1, // The thickness of the divider
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? WallpaperColor.black().color
                                    : WallpaperColor.white()
                                        .color, // The color of the divider
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Solicitud',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Hora: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${doc['hsolicitud']}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Fecha: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${doc['fsolicitud']}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Divider(
                              height: 10, // The height of the divider
                              thickness: 1, // The thickness of the divider
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white()
                                      .color, // The color of the divider
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Solicitud',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Hora: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            '${doc['hrespuesta']}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Fecha: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            '${doc['frespuesta']}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final collections = GetCollectionsServices();

    return StreamBuilder<QuerySnapshot>(
        stream: collections.getCollections('Creaciones', _pref.ultimateUid),
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
                title: const Center(child: Text('Creacion')),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      new_Creacion();
                    },
                    tooltip: 'Add',
                    alignment: Alignment.center,
                  ),
                ],
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.steelBlue().color
                        : WallpaperColor.kashmirBlue().color,
              ),
              drawer: const MyDrawer(),
              backgroundColor: Theme.of(context).colorScheme.background,
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
              title: const Center(child: Text('Creacion')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    new_Creacion();
                  },
                  tooltip: 'Add',
                  alignment: Alignment.center,
                ),
              ],
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? WallpaperColor.steelBlue().color
                  : WallpaperColor.kashmirBlue().color,
            ),
            drawer: const MyDrawer(),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: ListView.builder(
              itemCount: service?.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = service![index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String docID = document.id;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).brightness == Brightness.light
                          ? WallpaperColor.veniceBlue().color
                          : WallpaperColor.iceberg().color,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  data['restecnico'] == ''
                                      ? 'assets/ojo_cerrado.png'
                                      : 'assets/ojo_abierto.png',
                                  width: 50,
                                  height: 50,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? WallpaperColor.white().color
                                      : WallpaperColor.black().color,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize:
                                          MainAxisSize.min, // Add this line
                                      children: [
                                  Text(
                                    data['nombre'] != null &&
                                                    data['nombre'].length >
                                                        15
                                                ? '${data['nombre'].substring(0, 15)}...'
                                                : data['nombre'] ?? '',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize:
                                          MainAxisSize.min, // Add this line
                                      children: [
                                        Text(
                                          data['descripcion'] != null &&
                                                    data['descripcion'].length >
                                                        15
                                                ? '${data['descripcion'].substring(0, 15)}...'
                                                : data['descripcion'] ?? '',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info),
                                onPressed: () {
                                  details_Creacion(docID);
                                },
                                iconSize: 50,
                                tooltip: 'Add',
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? WallpaperColor.viking().color
                                    : WallpaperColor.blueZodiac().color,
                                alignment: Alignment.center,
                              ),
                              Text(
                                'Detalles',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
