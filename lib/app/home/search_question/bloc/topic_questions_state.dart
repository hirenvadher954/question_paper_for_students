part of 'topic_questions_bloc.dart';

abstract class TopicQuestionsState extends Equatable {
  const TopicQuestionsState();

  @override
  List<Object?> get props => [];
}

class TopicQuestionsEmpty extends TopicQuestionsState {}

class TopicQuestionsLoading extends TopicQuestionsState {}

class TopicQuestionsLoaded extends TopicQuestionsState {
  final List<SearchTopicQuestions> searchTopicQuestions;

  const TopicQuestionsLoaded({required this.searchTopicQuestions});

  @override
  List<Object> get props => [searchTopicQuestions];
}

class TopicQuestionsError extends TopicQuestionsState {}
