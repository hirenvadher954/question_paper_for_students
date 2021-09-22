part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class LoadNotes extends NotesEvent {
  @override
  List<Object?> get props => [];
}

class NotesUpdated extends NotesEvent {
  final List<Notes> notesList;

  const NotesUpdated(this.notesList);

  @override
  List<Object> get props => [notesList];
}
