// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_drawer.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/firebase/firestore.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:computic/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  final TextEditingController commentController = TextEditingController();

  final _pref = PreferencesUser();
  double califications = 0;

  String mantenimientoTag = 'mantenimientoTag';

  @override
  void dispose() {
    super.dispose();
  }

  void GuardarMantenimiento(String direccion) async {
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
    } else if (direccion == '') {
      LoadingScreen().hide();
      displayMessageToUser(
          'Debes agregar una direccion de tu punto de asistencia', context);
    } else if (direccion != '') {
      FirebaseFirestore.instance.collection('Servicios').doc().set({
        'servicio': 'Mantenimiento',
        'cliente': _pref.ultimateUid,
        'tipo': tipeController.text,
        'descripcion': desmaController.text,
        'tecnico': '',
        'asistiotf': null,
        'idtecnico': '',
        'restecnicotf': null,
        'asistenciatf': null,
        'restecnico': '',
        'direccion': direccion,
        'etapa': 'Tecnico No Asignado',
        'tectotal': '',
        'total': '',
        'fsolicitud': fsolicitud,
        'hsolicitud': hsolicitud,
        'frespuesta': '',
        'hrespuesta': '',
        'fllegada': '',
        'hllegada': '',
        'comentario': '',
        'estrellas': null,
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
                    onPressed: () async {
                      final DocumentSnapshot client = await FirebaseFirestore
                          .instance
                          .collection('Users')
                          .doc(_pref.ultimateUid)
                          .get();

                      String direccion = client.get('direccion');

                      print('Direccion: $direccion');
                      GuardarMantenimiento(direccion);
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

  void details_Mantenimiento(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de su mantenimiento'),
          icon: const Icon(Icons.build),
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

                DateTime now = DateTime.now();
                final fahora = DateFormat('dd-MM-yyyy').format(now);

                DateTime? eightHoursLater;

                if (doc['hllegada'] != null) {
                  try {
                    DateTime parsedHllegada =
                        DateFormat("HH:mm:ss").parse(doc['hllegada']);
                    eightHoursLater =
                        parsedHllegada.add(const Duration(hours: 8));
                  } catch (e) {
                    print('Error parsing date: $e');
                  }
                }

                bool isEightHoursLaterGreaterThanNow =
                    eightHoursLater != null && eightHoursLater.isAfter(now);

                print(isEightHoursLaterGreaterThanNow);
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
                              children: [
                                Text(
                                  'Tipo de PC: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${doc['tipo']}',
                                  style: const TextStyle(fontSize: 15),
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Descripcion: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${doc['descripcion']}',
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left,
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          if (doc['tecnico'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['tecnico']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['tecnico'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == true)
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Fecha de Llegada del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == true)
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['fllegada']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == true)
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == true)
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Hora de Llegada del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == true)
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['hllegada']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnicotf'] == null &&
                              doc['asistenciatf'] != true)
                            Divider(
                              height: 10, // The height of the divider
                              thickness: 1, // The thickness of the divider
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white()
                                      .color, // The color of the divider
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] != true)
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Fecha y Hora propuesta por el Tecnico:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] != true)
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] != true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Fecha: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        doc['fllegada'] == ''
                                            ? 'En modificacion'
                                            : '${doc['fllegada']}',
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Hora: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        doc['hllegada'] == ''
                                            ? 'En modificacion'
                                            : '${doc['hllegada']}',
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (doc['restecnicotf'] == true &&
                              doc['asistenciatf'] == null)
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['etapa'] == 'Fecha de Asistencia Propuesta' &&
                              doc['asistenciatf'] == null &&
                              doc['fllegada'] != '' &&
                              doc['hllegada'] != '')
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 20),
                              child: Column(
                                children: [
                                  Divider(
                                    height: 10, // The height of the divider
                                    thickness:
                                        1, // The thickness of the divider
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? WallpaperColor.black().color
                                        : WallpaperColor.white()
                                            .color, // The color of the divider
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '¿Acepta la fecha y hora que propuso el Tecnico asignado?',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: WallpaperColor.baliHai().color,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Servicios')
                                                .doc(id)
                                                .update({
                                              'asistenciatf': false,
                                              'hllegada': '',
                                              'fllegada': ''
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No Acepto',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Container(
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color:
                                              WallpaperColor.blueZodiac().color,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Servicios')
                                                .doc(id)
                                                .update({
                                              'asistenciatf': true,
                                              'etapa':
                                                  'Fecha de Asistencia Aceptada'
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Acepto',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnico'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['etapa'] == 'Respuesta del Tecnico')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          if (doc['etapa'] == 'Respuesta del Tecnico')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      doc['etapa'] == 'Respuesta del Tecnico' &&
                                              doc['restecnico'] == ''
                                          ? 'Esperando respuesta del tecnico...'
                                          : '${doc['restecnico']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnico'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['total'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Total: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          if (doc['total'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doc['total']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['total'] != '' && doc['comentario'] == '')
                            const SizedBox(
                              height: 10,
                            ),
                          if (doc['total'] != '' && doc['comentario'] == '')
                            Column(
                              children: [
                                RatingBar(
                                  initialRating: califications,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.amber),
                                    half: const Icon(Icons.star_half,
                                        color: Colors.amber),
                                    empty: const Icon(Icons.star_border,
                                        color: Colors.amber),
                                  ),
                                  onRatingUpdate: (rating) {
                                    print('Calificación: $rating');
                                    setState(() {
                                      califications = rating;
                                    });
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: MyTextField(
                                      labelText: 'Comentario',
                                      obscureText: false,
                                      controller: commentController),
                                ),
                                Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: WallpaperColor.baliHai().color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      LoadingScreen().show(context);
                                      if (commentController.text != '' &&
                                          califications > 0) {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('Servicios')
                                              .doc(id)
                                              .update({
                                            'estrellas': califications,
                                            'comentario':
                                                commentController.text,
                                          });
                                          califications = 0;
                                          commentController.clear();
                                          LoadingScreen().hide();
                                          displayMessageToUser(
                                              'Has comentado', context);
                                          Navigator.pop(context);
                                        } catch (e) {
                                          califications = 0;
                                          commentController.clear();
                                          LoadingScreen().hide();
                                          displayMessageToUser(
                                              'Ocurrio el siguiente error: $e',
                                              context);
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        califications = 0;
                                        commentController.clear();
                                        LoadingScreen().hide();
                                        displayMessageToUser(
                                            'Debes agregar un comentario y estrellas',
                                            context);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('Calificar'),
                                  ),
                                ),
                              ],
                            ),
                          if (doc['total'] == '')
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? 'assets/14.png'
                                      : 'assets/13.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (doc['estrellas'] != null &&
                              doc['comentario'] != '')
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Tú Comentario: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${doc['comentario']}',
                                              style:
                                                  const TextStyle(fontSize: 15),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RatingBar(
                                      initialRating: doc['estrellas'],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 30.0,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.amber),
                                        half: const Icon(Icons.star_half,
                                            color: Colors.amber),
                                        empty: const Icon(Icons.star_border,
                                            color: Colors.amber),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print('Calificación: $rating');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (doc['asistenciatf'] == true &&
                              doc['etapa'] == 'Fecha de Asistencia Aceptada' &&
                              isEightHoursLaterGreaterThanNow == false &&
                              doc['fllegada'] == fahora &&
                              doc['restecnicotf'] == true)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? WallpaperColor.blueZodiac().color
                                      : WallpaperColor.baliHai().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Servicios')
                                          .doc(id)
                                          .update({
                                        'asistiotf': true,
                                        'etapa': 'Tecnico Asistio'
                                      });
                                      Navigator.pop(context);
                                      print('Llego a tiempo');
                                    },
                                    child: const Text('Llego a tiempo',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  ),
                                ),
                              ),
                            ),
                          if (doc['asistenciatf'] == true &&
                              doc['etapa'] == 'Fecha de Asistencia Aceptada' &&
                              isEightHoursLaterGreaterThanNow == true &&
                              doc['restecnicotf'] == true)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? WallpaperColor.blueZodiac().color
                                      : WallpaperColor.baliHai().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Servicios')
                                          .doc(id)
                                          .update({
                                        'asistiotf': null,
                                        'tecnico': '',
                                        'idtecnico': '',
                                        'restecnicotf': null,
                                        'asistenciatf': null,
                                        'restecnico': '',
                                        'etapa': 'Tecnico No Asignado',
                                        'fllegada': '',
                                        'hllegada': '',
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Llego Tarde',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Entrega',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
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
                          if (doc['etapa'] != '' && doc['total'] == '')
                            Container(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${doc['etapa']}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['total'] != '')
                            Container(
                              alignment: Alignment.topCenter,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Trabajo Terminado',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    new_Mantenimiento();
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
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  new_Mantenimiento();
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
                                data['total'] == ''
                                    ? data['tecnico'] == ''
                                        ? 'assets/ojo_cerrado.png'
                                        : 'assets/ojo_abierto.png'
                                    : 'assets/lograr.png',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data['tipo'] != null &&
                                                data['tipo'].length > 15
                                            ? '${data['tipo'].substring(0, 15)}...'
                                            : data['tipo'] ?? '',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        data['descripcion'] != null &&
                                                data['descripcion'].length > 15
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
                                details_Mantenimiento(docID);
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
                                  color: Theme.of(context).colorScheme.primary),
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
      },
    );
  }
}
