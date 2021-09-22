import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/repository/notes_section/models/Notes.dart';
import 'package:gtu_question_paper/repository/notes_section/notes_repository.dart';

part 'notes_event.dart';

part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NotesLoading());

  final NotesRepository _notesRepository;
  StreamSubscription? _notesSubscription;

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is LoadNotes) {
      yield* _mapLoadNotesState();
    } else if (event is NotesUpdated) {
      yield* _mapNotesUpdateToState(event);
    }
  }

  Stream<NotesState> _mapLoadNotesState() async* {
    _notesSubscription?.cancel();
    _notesSubscription = _notesRepository.notesList().listen(
          (notesList) => add(NotesUpdated(notesList)),
        );
  }

  Stream<NotesState> _mapNotesUpdateToState(NotesUpdated event) async* {
    yield NotesLoaded(event.notesList);
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
