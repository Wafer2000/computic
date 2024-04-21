// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/my_button.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/components/routes/views/home.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExtraData extends StatefulWidget {
  const ExtraData({super.key});

  @override
  State<ExtraData> createState() => _ExtraDataState();
}

class _ExtraDataState extends State<ExtraData> {
  final TextEditingController fotoPerfilController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController agePassController = TextEditingController();

  void Guardar() async {
    var pref = PreferencesUserComputic();
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (fotoPerfilController.text == '') {
      displayMessageToUser('Debe colocar su foto de perfil', context);
    }
    if (addressController.text == '') {
      displayMessageToUser('Debe colocar su direccion', context);
    }
    if (sexController.text == '') {
      displayMessageToUser('Debe colocar su sexo', context);
    }
    if (phoneController.text == '') {
      displayMessageToUser('Debe colocar su numero celular', context);
    }
    if (agePassController.text == '') {
      displayMessageToUser('Debe colocar su fecha de nacimiento', context);
    } else {
      try {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(pref.ultimateUid)
            .update({
          'fnacimiento': fotoPerfilController.text,
          'celular': addressController.text,
          'fperfil': sexController.text,
          'sexo': phoneController.text,
          'direccion': agePassController.text,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'COMPUTIC',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                    hintText: 'Foto de Perfil',
                    obscureText: false,
                    controller: fotoPerfilController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Direccion de Residencia',
                    obscureText: false,
                    controller: addressController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Sexo',
                    obscureText: false,
                    controller: sexController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Numero Celular',
                    obscureText: false,
                    controller: phoneController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Fecha de Nacimiento',
                    obscureText: false,
                    controller: agePassController),
                const SizedBox(
                  height: 10,
                ),
                MyButton(text: 'Guardar', onTap: Guardar),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
