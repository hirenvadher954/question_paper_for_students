import 'dart:async';

import 'package:gtu_question_paper/app/home/search_question/models/search_topic_questions.dart';
import 'package:gtu_question_paper/app/home/selected_search_question/models/selected_topic_question.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_questions_api_client.dart';

class SearchTopicQuestionsRepository {
  final SearchTopicQuestionsApiClient searchTopicQuestionsApiClient;

  SearchTopicQuestionsRepository({required this.searchTopicQuestionsApiClient});

  Future<List<SearchTopicQuestions>> fetchSearchQuestions(String query) async {
    return await searchTopicQuestionsApiClient.fetchSearchQuestions(query);
  }

  Future<List<SelectedTopicQuestion>> fetchSelectedQuestion(
      {required int topicId, required int qaId}) async {
    return await searchTopicQuestionsApiClient.fetchSelectedQuestion(topicId,qaId);
  }
}
