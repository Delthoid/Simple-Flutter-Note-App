import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late FocusNode focusTitle;

  String title = '';
  String date = '';
  String content = '';
  String color = '';

  bool editMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusTitle = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String valueString = widget.note.color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return Scaffold(
      backgroundColor: otherColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 120,
                        height: 44,
                        child: Row(
                          children: [
                            const Icon(FeatherIcons.calendar),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(child: Text(DateFormat("MMM dd, yyyy").format(widget.note.date).toString())),
                          ],
                        ),
                      ),
                    ),
                    editMode
                        ? IconButton(onPressed: () => updateNote(), icon: const Icon(FeatherIcons.save))
                        : IconButton(
                            onPressed: () => setState(() {
                              editMode = true;
                              focusTitle.requestFocus();
                            }),
                            icon: const Icon(FeatherIcons.edit2),
                          ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'This note will be deleted',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Just kidding')),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await deleteNote();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Confirm')),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(FeatherIcons.trash2))
                  ],
                ),
                Expanded(
                  child: Form(
                    //key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          //enabled: editMode ? true : false,
                          style: Theme.of(context).textTheme.headline2,
                          initialValue: widget.note.title,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add some title';
                            }
                            return null;
                          },
                          onChanged: (value) => setState(() => title = value),
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: editMode ? true : false,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            initialValue: widget.note.content,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type something...',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add some text here...';
                              }
                              return null;
                            },
                            onChanged: (value) => setState(() => content = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateNote() async {
    final note = Note(
      id: widget.note.id,
      title: title.isEmpty ? widget.note.title : title,
      content: content.isEmpty ? widget.note.content : content,
      color: widget.note.color,
      date: widget.note.date,
    );
    await NotesDatabase.instance.update(note);
    //var test = await NotesDatabase.instance.readNote(int.parse(widget.note.id.toString()));
    Navigator.of(context).pop();
  }

  Future deleteNote() async {
    final noteId = int.parse(widget.note.id.toString());
    await NotesDatabase.instance.delete(noteId);
    Navigator.of(context).pop();
  }
}
