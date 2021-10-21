import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/themes/palette.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    Key? key,
    required this.action,
    required this.note,
  }) : super(key: key);

  final Note note;
  final Function() action;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  double opcaityValue = 0.5;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          opcaityValue = 1;
        }));
  }

  @override
  Widget build(BuildContext context) {
    String valueString = widget.note.color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Opacity(
        opacity: opcaityValue,
        child: Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: otherColor,
            boxShadow: [
              BoxShadow(
                color: otherColor,
                blurRadius: 5,
                offset: const Offset(1, 0),
              ),
            ],
          ),
          child: InkWell(
            onTap: widget.action,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(widget.note.date),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    widget.note.content,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
