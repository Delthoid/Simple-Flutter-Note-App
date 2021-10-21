import 'package:flutter/material.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/modules/screens/view_note.dart';

import 'notecard.dart';

class DissmisibleCard extends StatelessWidget {
  const DissmisibleCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        await NotesDatabase.instance.delete(int.parse(note.id.toString()));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: NoteCard(
          note: note,
          action: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewNote(note: note),
              ),
            );
          },
        ),
      ),
    );
  }
}
