import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/themes/palette.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.action,
    required this.note,
  }) : super(key: key);

  final Note note;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    String valueString = note.color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: otherColor,
      ),
      child: InkWell(
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                DateFormat('yyyy-MM-dd – kk:mm').format(note.date),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const Divider(color: Colors.transparent),
              Text(note.content),
            ],
          ),
        ),
      ),
    );
  }
}
