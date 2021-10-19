import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notes_app_delthoid/themes/palette.dart';
import 'package:notes_app_delthoid/widgets/custom_button.dart';
import 'package:notes_app_delthoid/widgets/notecard.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteSmoke,
      // appBar: AppBar(
      //   title: Text(
      //     'My Notes',
      //     style: Theme.of(context).textTheme.headline1,
      //   ),
      // ),
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
                        //width: 200,
                        //height: 44,
                        child: Row(
                          children: const [
                            Icon(FeatherIcons.calendar),
                            SizedBox(width: 10),
                            Text('Select Date'),
                          ],
                        ),
                      ),
                      CustomButton(
                        title: 'Save',
                        icon: const Icon(
                          FeatherIcons.save,
                        ),
                        action: () {},
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
                      color: Colors.pink[50],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
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
                            ),
                          ),
                        ],
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
}
