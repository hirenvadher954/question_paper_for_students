import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/repository/find_paper/find_paper_repository.dart';
import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

part 'find_paper_event.dart';

part 'find_paper_state.dart';

class FindPaperBloc extends Bloc<FindPaperEvent, FindPaperState> {
  FindPaperBloc({required FindPaperRepository findpaperRepository})
      : _findpaperRepository = findpaperRepository,
        super(FindPaperLoading());
  final FindPaperRepository _findpaperRepository;
  StreamSubscription? _findPaperSubscription;

  @override
  Stream<FindPaperState> mapEventToState(
    FindPaperEvent event,
  ) async* {
    if (event is LoadFindPapers) {
      yield* _mapLoadFindPaperToState();
    } else if (event is FindPaperUpdated) {
      yield* _mapFindPaperUpdateToState(event);
    }
  }

  Stream<FindPaperState> _mapLoadFindPaperToState() async* {
    _findPaperSubscription?.cancel();
    _findPaperSubscription = _findpaperRepository.paperList().listen(
          (paperList) => add(FindPaperUpdated(paperList)),
        );
  }

  Stream<FindPaperState> _mapFindPaperUpdateToState(
      FindPaperUpdated event) async* {
    yield FindPaperLoaded(event.paperList);
  }

  @override
  Future<void> close() {
    _findPaperSubscription?.cancel();
    return super.close();
  }
}
