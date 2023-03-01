part of 'repository.dart';

CollectionReference notes = FirebaseFirestore.instance.collection('note');

class NoteRepository {
  static Future<void> getData(
      {required String uid, required ValueSetter<List<Note>> setData}) async {
    List<Note> allData = [];

    try {
      QuerySnapshot<Object?> res =
          await notes.where('id', isEqualTo: uid).get();
      res.docs.forEach(
        (element) {
          Map<String, dynamic> dataJson =
              element.data() as Map<String, dynamic>;
          Note data = Note.fromJson(dataJson);
          allData.add(data);
        },
      );
      setData(allData);
    } catch (e) {
      print(e.toString());
    }

    // inspect(res.docs);
  }
}
