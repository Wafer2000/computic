import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCollectionsServices {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollections(String service, String client) {
    final services = _firestore
        .collection('Servicios')
        .where('servicio', isEqualTo: service)
        .where('cliente', isEqualTo: client)
        .snapshots();
    return services;
  }
}
