import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtu_question_paper/repository/notes_section/notes_repository.dart';

import 'entities/notes_entity.dart';
import 'models/Notes.dart';

class FirebaseNotesRepository implements NotesRepository {
  final notesCollection = FirebaseFirestore.instance.collection('notesList');

  @override
  Stream<List<Notes>> notesList() {
    return notesCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Notes.fromEntity(
              NotesEntity.fromSnapshot(doc),
            ))
        .toList());
  }
}
