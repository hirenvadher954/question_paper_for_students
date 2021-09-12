part of 'topic_questions_bloc.dart';

abstract class TopicQuestionsEvent extends Equatable {
  const TopicQuestionsEvent();
}


class FetchTopicQuestions extends TopicQuestionsEvent {
  const FetchTopicQuestions({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
