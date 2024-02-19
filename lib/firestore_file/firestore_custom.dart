import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceCustom {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('collection');

  //READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }
}

/*class FirestoreServiceCustom {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('collection');
  List<DocumentSnapshot> cachedNotes = []; // 캐시된 노트 목록

  // Firestore에서 노트 스트림을 가져오는 메서드
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    notesStream.listen((snapshot) {
      cachedNotes = snapshot.docs; // 스트림 업데이트 시 캐시 업데이트
    });
    return notesStream;
  }

  // 캐시된 노트 데이터 초기화 메서드
  void clearCachedNotes() {
    cachedNotes = [];
  }
}*/
