import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/app/home/selected_search_question/models/selected_topic_question.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_question_repository.dart';

part 'selected_question_event.dart';

part 'selected_question_state.dart';

class SelectedQuestionBloc
    extends Bloc<SelectedQuestionEvent, SelectedQuestionState> {
  SelectedQuestionBloc({required this.repository})
      : super(SelectedQuestionEmpty());

  final SearchTopicQuestionsRepository repository;

  @override
  Stream<SelectedQuestionState> mapEventToState(
    SelectedQuestionEvent event,
  ) async* {
    if (event is FetchSelectedQuestion) {
      yield SelectedQuestionLoading();
      try {
        final List<SelectedTopicQuestion> selectedTopicQuestion =
            await repository.fetchSelectedQuestion(
                topicId: event.topicId, qaId: event.qaId);
        yield SelectedQuestionLoaded(
            selectedTopicQuestion: selectedTopicQuestion);
      } catch (e) {
        yield SelectedQuestionsError();
      }
    }
  }
}
