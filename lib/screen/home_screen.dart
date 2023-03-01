import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/repository/repository.dart';
import 'package:map_exam/screen/edit_screen.dart';
import 'package:map_exam/widget/list_note.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QueryDocumentSnapshot<Object?>> docsNote = [];
  String uid = '';
  bool isContentHidden = false;
  int? editIndex;

  @override
  void initState() {
    super.initState();
    AuthRepository.checkAuth(
      context: context,
      setUserUid: (value) {
        setState(() {
          uid = value;
        });
        getData();
      },
    );
  }

  void getData() {
    NoteRepository.getData(
      uid: uid,
      setData: (value) => setState(() {
        docsNote = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: Text(
              docsNote.length.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: docsNote.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) {
          // QueryDocumentSnapshot<Object?> itemNote = docsNote[index];
          return ListNote(
            key: UniqueKey(),
            isContentHidden: isContentHidden,
            itemDocs: docsNote[index],
            editIndex: editIndex,
            userUid: uid,
            itemIndex: index,
            setEditIndex: (value) => setState(() {
              editIndex = value;
            }),
            onRefresh: getData,
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isContentHidden
              ? FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.menu),
                  tooltip: 'Show more. Show notes content',
                  onPressed: () => setState(() {
                        isContentHidden = false;
                      }))
              : FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.unfold_less),
                  tooltip: 'Show less. Hide notes content',
                  onPressed: () => setState(() {
                        isContentHidden = true;
                      })),

          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () => Navigator.push(
                    context, EditScreen.route(status: 'add', userUid: uid))
                .then((value) => getData()),
          ),
        ],
      ),
    );
  }
}
