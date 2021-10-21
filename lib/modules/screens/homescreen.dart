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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    title: isGridMode ? 'List View' : 'Grid View',
                    icon: Icon(
                      isGridMode ? FeatherIcons.list : FeatherIcons.grid,
                    ),
                    action: () async {
                      isGridMode = !isGridMode;
                      refreshNotes();
                    },
                  ),
                  CustomButton(
                    title: 'New',
                    icon: const Icon(
                      FeatherIcons.plusCircle,
                    ),
                    action: () async {
                      await Navigator.pushNamed(context, '/add_note');
                      refreshNotes();
                    },
                  ),
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
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        final note = notes[index];
        var id = note.id.toString();
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await NotesDatabase.instance.delete(int.parse(id));
            setState(() {
              refreshNotes();
            });
          },
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
      },
    );
  }

  Widget listNotes() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        var id = note.id.toString();
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await NotesDatabase.instance.delete(int.parse(id));
            setState(() {
              refreshNotes();
            });
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
                refreshNotes();
              },
            ),
          ),
        );
      },
    );
  }
}
