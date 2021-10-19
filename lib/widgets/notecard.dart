import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.title,
    required this.date,
    required this.content,
    required this.action,
  }) : super(key: key);

  final String title;
  final String date;
  final String content;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.pink[50],
      ),
      child: InkWell(
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              const Divider(color: Colors.transparent),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
