import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/model/note.dart';
import 'package:map_exam/repository/repository.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> dataNote = [];
  String uid = '';
  bool isContentHidden = false;

  @override
  void initState() {
    super.initState();
    AuthRepository.checkAuth(
      context: context,
      setUserUid: (value) {
        setState(() {
          uid = value;
          NoteRepository.getData(
            uid: uid,
            setData: (value) => setState(() {
              dataNote = value;
            }),
          );
        });
      },
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
              dataNote.length.toString(),
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
        itemCount: dataNote.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) {
          Note itemNote = dataNote[index];
          return ListTile(
            // trailing: SizedBox(
            //   width: 110.0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.edit, color: Colors.blue),
            //         onPressed: () {
            //           FirebaseAuth.instance.signOut();
            //         },
            //       ),
            //       IconButton(
            //         icon: const Icon(
            //           Icons.delete,
            //           color: Colors.blue,
            //         ),
            //         onPressed: () {},
            //       ),
            //     ],
            //   ),
            // ),
            title: Text(itemNote.title ?? ''),
            subtitle: isContentHidden ? null : Text(itemNote.content ?? ''),
            onTap: () {},
            onLongPress: () {},
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
