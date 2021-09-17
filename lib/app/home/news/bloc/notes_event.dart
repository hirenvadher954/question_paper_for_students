part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class FetchNotes extends NotesEvent {

  @override
  List<Object?> get props => [];
}
