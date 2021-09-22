import 'dart:async';

import 'models/Notes.dart';
abstract class NotesRepository {
  Stream<List<Notes>> notesList();
}
