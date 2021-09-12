import 'dart:convert';

List<SelectedTopicQuestion> selectedTopicQuestionFromJson(String str) => List<SelectedTopicQuestion>.from(json.decode(str).map((x) => SelectedTopicQuestion.fromJson(x)));

String selectedTopicQuestionToJson(List<SelectedTopicQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedTopicQuestion {
  SelectedTopicQuestion({
    required this.id,
    this.topicId,
    required this.topicQuestion,
    required this.topicAnswer,
  });

  int id;
  dynamic topicId;
  String topicQuestion;
  String topicAnswer;

  factory SelectedTopicQuestion.fromJson(Map<String, dynamic> json) => SelectedTopicQuestion(
    id: json["id"],
    topicId: json["topic_id"],
    topicQuestion: json["topic_question"],
    topicAnswer: json["topic_answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic_id": topicId,
    "topic_question": topicQuestion,
    "topic_answer": topicAnswer,
  };
}
