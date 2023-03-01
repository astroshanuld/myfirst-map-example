import 'package:flutter/material.dart';
import 'package:map_exam/model/note.dart';
import 'package:map_exam/repository/repository.dart';

class EditScreen extends StatefulWidget {
  static Route route(
          {required String status,
          required String userUid,
          String? docId,
          Note? dataNote}) =>
      MaterialPageRoute(
          builder: (_) => EditScreen(
                status: status,
                userUid: userUid,
                docId: docId,
                dataNote: dataNote,
              ));
  final String status;
  final String userUid;
  final String? docId;
  final Note? dataNote;

  const EditScreen(
      {Key? key,
      required this.status,
      required this.userUid,
      this.docId,
      this.dataNote})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _titleController = TextEditingController(text: widget.dataNote?.title);
      _descriptionController =
          TextEditingController(text: widget.dataNote?.content);
    });
  }

  void submit() {
    // if (widget.status == 'add') {
    //   NoteRepository.createData(
    //           data: Note(
    //               id: widget.userUid,
    //               content: _descriptionController.text,
    //               title: _titleController.text))
    //       .then((value) => Navigator.pop(context, true));
    // }
    // if (widget.status == 'edit') {
    //   NoteRepository.updateData(
    //           docId: widget.docId!,
    //           data: Note(
    //               id: widget.userUid,
    //               content: _descriptionController.text,
    //               title: _titleController.text))
    //       .then((value) => Navigator.pop(context, true));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(widget.status == 'view'
            ? 'View Note'
            : widget.status == 'edit'
                ? 'Edit Note'
                : 'Add New Note'),
        actions: [
          widget.status == 'view'
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    size: 30,
                  ),
                  onPressed: submit),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              initialValue: null,
              enabled: widget.status == 'view' ? false : true,
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                  controller: _descriptionController,
                  enabled: widget.status == 'view' ? false : true,
                  initialValue: null,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type the description',
                  ),
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
