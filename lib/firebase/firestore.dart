import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
      
  //Create
  Future<DocumentReference<Object?>> addNote(String note) async {
    return await notes.add({'note': note, 'timestamp': Timestamp.now});
  }

  //Read

  //Update

  //Delete
}
