import 'package:flutter/material.dart';
import 'package:map_exam/model/note.dart';

class ListNote extends StatefulWidget {
  final bool isContentHidden;
  final Note itemNote;
  final int itemIndex;
  final ValueSetter<int?> setEditIndex;
  final int? editIndex;
  const ListNote(
      {Key? key,
      required this.isContentHidden,
      required this.itemNote,
      required this.itemIndex,
      required this.setEditIndex,
      required this.editIndex})
      : super(key: key);

  @override
  _ListNoteState createState() => _ListNoteState();
}

class _ListNoteState extends State<ListNote> {
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          : null,
      title: Text(widget.itemNote.title ?? ''),
      subtitle:
          widget.isContentHidden ? null : Text(widget.itemNote.content ?? ''),
      onTap: () {},
      onLongPress: () => widget.editIndex == widget.itemIndex
          ? widget.setEditIndex(null)
          : widget.setEditIndex(widget.itemIndex),
    );
  }
}
