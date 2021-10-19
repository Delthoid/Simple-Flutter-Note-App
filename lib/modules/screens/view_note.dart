import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notes_app_delthoid/themes/palette.dart';
import 'package:notes_app_delthoid/widgets/custom_button.dart';
import 'package:notes_app_delthoid/widgets/notecard.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({Key? key}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteSmoke,
      appBar: AppBar(
        title: const Text('view NOte'),
      ),
      body: SizedBox(
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
              SizedBox(
                width: 200,
                height: 44,
                child: Row(
                  children: const [
                    Icon(FeatherIcons.grid),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Display by grid'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: NoteCard(
                        title: 'asd',
                        date: 'asdasd',
                        content: 'asdas',
                        action: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
