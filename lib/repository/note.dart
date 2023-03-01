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

  static Future<void> createData({required Note data}) async {
    try {
      await notes.add(data.toJson());
      print('Successfully add data!');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> updateData(
      {required String docId, required Note data}) async {
    try {
      await notes.doc(docId).update(data.toJson());
      print('Successfully update data!');
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
