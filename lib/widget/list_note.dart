import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/model/note.dart';
import 'package:map_exam/repository/repository.dart';
import 'package:map_exam/screen/edit_screen.dart';

class ListNote extends StatefulWidget {
  final bool isContentHidden;
  final QueryDocumentSnapshot<Object?> itemDocs;
  final int itemIndex;
  final String userUid;
  final ValueSetter<int?> setEditIndex;
  final int? editIndex;
  final VoidCallback onRefresh;
  const ListNote(
      {Key? key,
      required this.isContentHidden,
      required this.itemDocs,
      required this.itemIndex,
      required this.userUid,
      required this.setEditIndex,
      required this.editIndex,
      required this.onRefresh})
      : super(key: key);

  @override
  _ListNoteState createState() => _ListNoteState();
}

class _ListNoteState extends State<ListNote> {
  Note dataNote = Note();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    Map<String, dynamic> dataJson =
        widget.itemDocs.data() as Map<String, dynamic>;
    Note data = Note.fromJson(dataJson);
    setState(() {
      dataNote = data;
    });
  }

  void delete() {
    widget.setEditIndex(null);
    NoteRepository.deleteData(docId: widget.itemDocs.id);
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: widget.editIndex == widget.itemIndex
          ? SizedBox(
              width: 110.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => Navigator.push(
                            context,
                            EditScreen.route(
                                status: 'edit',
                                userUid: widget.userUid,
                                dataNote: dataNote,
                                docId: widget.itemDocs.id))
                        .then((value) => widget.onRefresh()),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    onPressed: delete,
                  ),
                ],
              ),
            )
          : null,
      title: Text(dataNote.title ?? ''),
      subtitle: widget.isContentHidden ? null : Text(dataNote.content ?? ''),
      onTap: () => Navigator.push(
          context,
          EditScreen.route(
              status: 'view',
              docId: widget.itemDocs.id,
              userUid: widget.userUid,
              dataNote: dataNote)),
      onLongPress: () => widget.editIndex == widget.itemIndex
          ? widget.setEditIndex(null)
          : widget.setEditIndex(widget.itemIndex),
    );
  }
}
