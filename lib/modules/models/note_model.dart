const String notes = 'notes';

class NotesFields {
  static final List<String> values = [id, title, date, content];

  static const String id = 'id';
  static const String title = 'title';
  static const String date = 'date';
  static const String content = 'content';
}

class Note {
  final int? id;
  final String title;
  final String date;
  final String content;

  const Note({this.id, required this.title, required this.date, required this.content});

  Note copy({
    int? id,
    String? title,
    String? date,
    String? content,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        content: content ?? this.content,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NotesFields.id] as int?,
        title: json[NotesFields.title] as String,
        date: json[NotesFields.date] as String,
        content: json[NotesFields.content] as String,
      );

  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.title: title,
        NotesFields.date: date,
        NotesFields.content: content,
      };
}
