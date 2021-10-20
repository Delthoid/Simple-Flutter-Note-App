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
  String color = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteSmoke,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              // left: 24,
              // right: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 24,
                    right: 24,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Color',
                          action: () => showDialog(
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
                                        print('colorrrr $color ' + color.isEmpty.toString());
                                        print(color.toString());
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              }),
                          icon: const Icon(Icons.color_lens),
                        ),
                      ),
                      CustomButton(
                        title: 'Save',
                        icon: const Icon(
                          FeatherIcons.save,
                        ),
                        action: () {
                          if (_formKey.currentState!.validate()) {
                            addOrUpdate();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: selectedColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: Theme.of(context).textTheme.headline2,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      hintText: 'Add title',
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
                                    onChanged: (title) => setState(() => this.title = title),
                                  ),
                                ),
                              ],
                            ),
                            //const Divider(color: Colors.transparent),
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
    // final isValid = _formKey.currentState!.validate();
    // if(isValid){
    //   final
    // }
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
