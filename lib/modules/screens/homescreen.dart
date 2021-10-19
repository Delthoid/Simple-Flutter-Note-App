import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/themes/palette.dart';
import 'package:notes_app_delthoid/widgets/custom_button.dart';
import 'package:notes_app_delthoid/widgets/notecard.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    populate();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  //try to populate
  Future populate() async {
    var note = const Note(
      title: 'Test title',
      content: 'content',
      date: 'test date',
    );

    await NotesDatabase.instance.create(note);
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteSmoke,
      appBar: AppBar(
        title: Text(
          'My Notes',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const CustomButton(title: 'Add new note'),
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
              Row(
                children: [
                  Expanded(
                    //width: 200,
                    //height: 44,
                    child: Row(
                      children: const [
                        Icon(FeatherIcons.grid),
                        SizedBox(width: 10),
                        Text('Display by grid'),
                      ],
                    ),
                  ),
                  CustomButton(
                    title: 'New',
                    icon: const Icon(
                      FeatherIcons.plusCircle,
                    ),
                    action: () => Navigator.pushNamed(context, '/add_note'),
                  )
                ],
              ),
              const Divider(
                color: Colors.transparent,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : notes.isEmpty
                      ? const Center(
                          child: Text('No data'),
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              //notes.forEach((element) => print(element.id));
                              return Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: NoteCard(
                                  title: notes[index].title,
                                  date: notes[index].date,
                                  content: notes[index].content,
                                  action: () => Navigator.pushNamed(context, '/view_note'),
                                ),
                              );
                            },
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
