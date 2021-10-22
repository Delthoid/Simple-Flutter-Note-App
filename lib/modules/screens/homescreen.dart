import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/modules/screens/view_note.dart';
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
  bool isGridMode = true;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    List<Note> _notes = await NotesDatabase.instance.readAllNotes();
    setState(() => notes = _notes);
    print('hehe');
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteSmoke,
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const CustomButton(title: 'Add new note'),
      floatingActionButton: CustomButton(
        title: 'New',
        icon: const Icon(
          FeatherIcons.plus,
        ),
        action: () async {
          await Navigator.pushNamed(context, '/add_note');
          refreshNotes();
        },
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  CustomButton(
                    title: isGridMode ? 'List' : 'Grid',
                    icon: Icon(
                      isGridMode ? FeatherIcons.list : FeatherIcons.grid,
                    ),
                    action: () async {
                      isGridMode = !isGridMode;
                      refreshNotes();
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.transparent,
              ),
              isLoading
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    )
                  : notes.isEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(
                                child: Text('No data'),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: isGridMode ? staggeredNotes() : listNotes(),
                        )
            ],
          ),
        ),
      ),
    );
  }

  Widget staggeredNotes() {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: notes.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 0,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        final note = notes[index];
        var id = note.id.toString();
        return dissmisibleCard(note);
      },
    );
  }

  Widget listNotes() {
    return ListView.builder(
      //clipBehavior: Clip.none,

      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return dissmisibleCard(note);
      },
    );
  }

  Widget dissmisibleCard(Note note) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        await NotesDatabase.instance.delete(int.parse(note.id.toString()));
        setState(() {
          refreshNotes();
        });
      },
      background: Row(mainAxisAlignment: MainAxisAlignment.start, children: const [Icon(FeatherIcons.trash2)]),
      secondaryBackground: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [Icon(FeatherIcons.trash2)]),
      child: NoteCard(
        note: note,
        action: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewNote(note: note),
            ),
          );
          refreshNotes();
        },
      ),
    );
  }
}
