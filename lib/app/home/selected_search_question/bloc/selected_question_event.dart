part of 'selected_question_bloc.dart';

abstract class SelectedQuestionEvent extends Equatable {
  const SelectedQuestionEvent();
}

class FetchSelectedQuestion extends SelectedQuestionEvent {
  const FetchSelectedQuestion({required this.topicId, required this.qaId});

  final int topicId;
  final int qaId;

  @override
  List<Object?> get props => [topicId, qaId];
}
