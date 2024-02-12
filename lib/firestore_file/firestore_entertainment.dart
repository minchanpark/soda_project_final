import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiseEntertainment {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('entertainment');

  //READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }
}
