part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Notes> notesList;

  const NotesLoaded([this.notesList = const []]);

  @override
  List<Object> get props => [notesList];

  @override
  String toString() => 'NotesLoadSuccess { paperList: $notesList }';
}

class NotesNotLoaded extends NotesState {}
