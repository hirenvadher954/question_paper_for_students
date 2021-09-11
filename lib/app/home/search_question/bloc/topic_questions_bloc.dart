import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/app/home/search_question/models/search_topic_questions.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_question_repository.dart';

part 'topic_questions_event.dart';

part 'topic_questions_state.dart';

class TopicQuestionsBloc
    extends Bloc<TopicQuestionsEvent, TopicQuestionsState> {
  TopicQuestionsBloc({required this.repository})
      : super(TopicQuestionsEmpty());

  final SearchTopicQuestionsRepository repository;

  @override
  Stream<TopicQuestionsState> mapEventToState(
    TopicQuestionsEvent event,
  ) async* {
    if (event is FetchTopicQuestions) {
      yield TopicQuestionsLoading();
      try {
        final List<SearchTopicQuestions> searchTopicQuestions =
            await repository.fetchSearchQuestions();
        print("searchTopicQuestions");
        yield TopicQuestionsLoaded(searchTopicQuestions: searchTopicQuestions);
      } catch (e) {
        print(" IN error${e.toString()}");
        yield TopicQuestionsError();
      }
    }
  }
}
