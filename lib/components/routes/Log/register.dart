// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic/components/routes/Log/login.dart';
import 'package:computic/components/routes/tools/helper_functions.dart';
import 'package:computic/components/routes/tools/my_button.dart';
import 'package:computic/components/routes/tools/my_textfield.dart';
import 'package:computic/components/routes/views/guard/extra_data.dart';
import 'package:computic/shared/prefe_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void Registro() async {
    var pref = PreferencesUserComputic();
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text != confirmPassController.text) {
      Navigator.pop(context);
      displayMessageToUser('Las contraseñas no son iguales', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var uid = userCredential.user?.uid;
        pref.ultimateUid = uid!;
        FirebaseFirestore.instance.collection('Users').doc().set({
          'uid': uid,
          'nombres': firstnameController.text,
          'apellidos': lastnameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'fnacimiento': '',
          'celular': '',
          'fperfil': '',
          'sexo': '',
          'direccion': '',
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ExtraData()),
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
                    hintText: 'Nombres',
                    obscureText: false,
                    controller: firstnameController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Apellidos',
                    obscureText: false,
                    controller: lastnameController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Correo',
                    obscureText: false,
                    controller: emailController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Contraseña',
                    obscureText: true,
                    controller: passwordController),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: 'Confirmar Contraseña',
                    obscureText: true,
                    controller: confirmPassController),
                const SizedBox(
                  height: 10,
                ),
                MyButton(text: 'Registrar', onTap: Registro),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('¿Tienes una cuenta?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text('Ingresa aqui',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
