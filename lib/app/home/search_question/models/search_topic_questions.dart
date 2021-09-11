// To parse this JSON data, do
//
//     final searchTopicQuestions = searchTopicQuestionsFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<SearchTopicQuestions> searchTopicQuestionsFromJson(str) =>
    List<SearchTopicQuestions>.from(
        json.decode(str).map((x) => SearchTopicQuestions.fromJson(x)));

class SearchTopicQuestions extends Equatable {
  SearchTopicQuestions({
    required this.topicId,
    required this.topicName,
    required this.qaId,
    required this.topicQuestion,
  });

  int topicId;
  String topicName;
  int qaId;
  String topicQuestion;

  factory SearchTopicQuestions.fromJson(Map<String, dynamic> json) =>
      SearchTopicQuestions(
        topicId: json["topic_id"],
        topicName: json["topic_name"],
        qaId: json["qa_id"],
        topicQuestion: json["topic_question"],
      );

  @override
  List<Object?> get props => [topicId, topicName, qaId, topicQuestion];
}
