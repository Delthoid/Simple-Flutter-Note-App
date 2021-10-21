import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_delthoid/modules/models/note_model.dart';
import 'package:notes_app_delthoid/modules/screens/add_note.dart';
import 'package:notes_app_delthoid/modules/screens/homescreen.dart';
import 'package:notes_app_delthoid/modules/screens/view_note.dart';
import 'package:notes_app_delthoid/themes/light.dart';

import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Note',
      theme: lightTheme,
      //home: const NotesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const NotesScreen(),
        '/add_note': (context) => const AddNote(),
      },
    );
  }
}
