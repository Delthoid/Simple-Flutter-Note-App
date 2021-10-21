import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:notes_app_delthoid/db/notes_db.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/themes/palette.dart';
import 'package:notes_app_delthoid/widgets/custom_button.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var selectedColor = testColor;

  String title = '';
  String date = '';
  String content = '';
  String color = 'Color(0xffffcdd2)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Color _pickedcolor = Colors.red;
                            return AlertDialog(
                              title: const Text('Pick color'),
                              content: MaterialColorPicker(
                                onColorChange: (Color color) {
                                  _pickedcolor = color;
                                },
                                selectedColor: Colors.red,
                                colors: const [Colors.red, Colors.deepOrange, Colors.yellow, Colors.lightGreen],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() => selectedColor = _pickedcolor);
                                    color = selectedColor.toString();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: 120,
                        height: 44,
                        child: Row(
                          children: const [
                            Icon(Icons.color_lens_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(child: Text('Note Color')),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addOrUpdate();
                          }
                        },
                        icon: const Icon(FeatherIcons.save))
                  ],
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.headline2,
                          decoration: const InputDecoration(
                            hintText: 'Add title',
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please add some text here...';
                            //   }
                            //   return null;
                            // },
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

  void addOrUpdate() async {
    await saveNote();
    Navigator.of(context).pop();
  }

  Future saveNote() async {
    final note = Note(
      title: title,
      date: DateTime.now(),
      content: content,
      color: color,
    );
    print('selected color ' + color);
    await NotesDatabase.instance.create(note);
    //Navigator.of(context).pop();
  }
}
