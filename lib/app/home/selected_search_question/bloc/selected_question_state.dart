part of 'selected_question_bloc.dart';

abstract class SelectedQuestionState extends Equatable {
  const SelectedQuestionState();

  @override
  List<Object?> get props => [];
}

class SelectedQuestionEmpty extends SelectedQuestionState {}

class SelectedQuestionLoading extends SelectedQuestionState {}

class SelectedQuestionLoaded extends SelectedQuestionState {
  final List<SelectedTopicQuestion> selectedTopicQuestion;

  const SelectedQuestionLoaded({required this.selectedTopicQuestion});

  @override
  List<Object> get props => [selectedTopicQuestion];
}

class SelectedQuestionsError extends SelectedQuestionState {}
