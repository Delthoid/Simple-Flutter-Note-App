import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';

import 'package:notes_app_delthoid/themes/palette.dart';
import 'package:notes_app_delthoid/widgets/custom_button.dart';
import 'package:notes_app_delthoid/widgets/notecard.dart';

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
  String title = '';
  String date = '';
  String content = '';
  String color = '';

  @override
  Widget build(BuildContext context) {
    String valueString = widget.note.color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
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
                    IconButton(
                        onPressed: () {
                          updateNote();
                        },
                        icon: const Icon(FeatherIcons.save)),
                    IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.trash2))
                  ],
                ),
                Expanded(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
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
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            initialValue: widget.note.content,
                            style: const TextStyle(
                              fontSize: 14,
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
      title: title,
      content: content,
      color: widget.note.color,
      date: widget.note.date,
    );
    await NotesDatabase.instance.update(note);
    var test = await NotesDatabase.instance.readNote(int.parse(widget.note.id.toString()));
    print('test ' + test.title);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Updating note')),
    // );
    Navigator.of(context).pop();
  }
}
