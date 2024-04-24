// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/input_photo.dart';
import 'package:computic/components/routes/tools/loading_indicator.dart';
import 'package:computic/components/routes/tools/my_button.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/components/routes/views/maintenance.dart';
import 'package:computic/style/global_colors.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExtraData extends StatefulWidget {
  static const String routname = '/extra_data';
  const ExtraData({super.key});

  @override
  State<ExtraData> createState() => _ExtraDataState();
}

class _ExtraDataState extends State<ExtraData> {
  final _pref = PreferencesUserComputic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(_pref.ultimateUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const AlertDialog(
              title: Text('Algo salio mal'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Text('No hay datos');
          }
          final user = snapshot.data!;

          final TextEditingController fotoPerfilController =
              TextEditingController(text: user['fperfil']);
          final TextEditingController addressController =
              TextEditingController(text: user['direccion']);
          final TextEditingController sexController =
              TextEditingController(text: user['sexo']);
          final TextEditingController phoneController =
              TextEditingController(text: user['celular']);
          final TextEditingController ageController =
              TextEditingController(text: user['fnacimiento']);

          void openDataPicker(BuildContext context) {
            BottomPicker.date(
              pickerTitle: const Text(
                'Selecciona una fecha',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dateOrder: DatePickerDateOrder.dmy,
              pickerTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              onChange: (index) {
                ageController.text = DateFormat('dd/MM/yyyy').format(index);
              },
            ).show(context);
          }

          void Guardar() async {
            LoadingScreen().show(context);

            if (fotoPerfilController.text == '') {
              LoadingScreen().hide();
              displayMessageToUser('Debe colocar su foto de perfil', context);
            } else if (addressController.text == '') {
              LoadingScreen().hide();
              displayMessageToUser('Debe colocar su direccion', context);
            } else if (sexController.text == '') {
              LoadingScreen().hide();
              displayMessageToUser('Debe colocar su sexo', context);
            } else if (phoneController.text == '') {
              LoadingScreen().hide();
              displayMessageToUser('Debe colocar su numero celular', context);
            } else if (ageController.text == '') {
              LoadingScreen().hide();
              displayMessageToUser(
                  'Debe colocar su fecha de nacimiento', context);
            } else {
              try {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(_pref.ultimateUid)
                    .update({
                  'fnacimiento': ageController.text,
                  'celular': phoneController.text,
                  'fperfil': fotoPerfilController.text,
                  'sexo': sexController.text,
                  'direccion': addressController.text,
                });
                LoadingScreen().hide();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Maintenance()),
                );
              } on FirebaseAuthException catch (e) {
                LoadingScreen().hide();
                displayMessageToUser(e.code, context);
              }
            }
          }

          int edadf = 0;

          if (user['fnacimiento'] != '') {
            final DateFormat formatter = DateFormat('dd/MM/yyyy');
            final DateTime fechaNacimiento =
                formatter.parse(user['fnacimiento']);
            final DateTime now = DateTime.now();
            final int years = now.year - fechaNacimiento.year;
            int edad;
            if (now.month < fechaNacimiento.month ||
                (now.month == fechaNacimiento.month &&
                    now.day < fechaNacimiento.day)) {
              edad = years - 1;
            } else {
              edad = years;
            }
            edadf = edad;
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InputFotoPerfil(),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                        labelText: 'Direccion de Residencia',
                        obscureText: false,
                        controller: addressController),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        labelText: 'Sexo',
                        obscureText: false,
                        controller: sexController),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        labelText: 'Numero Celular',
                        obscureText: false,
                        controller: phoneController),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              openDataPicker(context);
                            },
                            child: SizedBox(
                              width: 170,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? WallpaperColor.viking().color
                                        : WallpaperColor.blueZodiac().color,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 10),
                                    Text(
                                      'Fecha de Nacimiento',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Edad: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            edadf == 0
                                ? 'Dato vacio'
                                : '${edadf.toString()} Años',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(text: 'Guardar', onTap: () => Guardar()),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
