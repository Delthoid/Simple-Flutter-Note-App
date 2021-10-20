import 'package:flutter/cupertino.dart';

const String notes = 'notes';

class NotesFields {
  static final List<String> values = [id, title, date, content, color];

  static const String id = 'id';
  static const String title = 'title';
  static const String date = 'date';
  static const String content = 'content';
  static const String color = 'color';
}

class Note {
  final int? id;
  final String title;
  final DateTime date;
  final String content;
  final String color;

  const Note({
    this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.color,
  });

  Note copy({
    int? id,
    String? title,
    DateTime? date,
    String? content,
    String? color,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        content: content ?? this.content,
        color: color ?? this.color,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NotesFields.id] as int?,
        title: json[NotesFields.title] as String,
        date: DateTime.parse(json[NotesFields.date] as String),
        content: json[NotesFields.content] as String,
        color: json[NotesFields.color] as String,
      );

  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.title: title,
        NotesFields.date: date.toIso8601String(),
        NotesFields.content: content,
        NotesFields.color: color,
      };
}
