import 'package:flutter/material.dart';
import 'package:hello/model/notes.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [
        ..._notes
      ];

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }
}