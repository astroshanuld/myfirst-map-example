part of 'repository.dart';

CollectionReference notes = FirebaseFirestore.instance.collection('note');

class NoteRepository {
  static Future<void> getData(
      {required String uid,
      required ValueSetter<List<QueryDocumentSnapshot<Object?>>>
          setData}) async {
    try {
      QuerySnapshot<Object?> res =
          await notes.where('id', isEqualTo: uid).get();
      setData(res.docs);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteData({required String docId}) async {
    try {
      await notes.doc(docId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
