import 'package:gtu_question_paper/app/home/search_question/models/search_topic_questions.dart';
import 'package:http/http.dart' as http;

class SearchTopicQuestionsApiClient {
  final _baseUrl = 'http://www.prajval.in:8080/PrajvalServicesV1.0/service';
  final http.Client httpClient;

  SearchTopicQuestionsApiClient({
    required this.httpClient,
  });

  Future<List<SearchTopicQuestions>> fetchSearchQuestions(String query) async {
    final url = query.length != 0
        ? '$_baseUrl/mainsearch/$query'
        : '$_baseUrl/mainsearch/java';

    final response = await this.httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    // final json = jsonDecode(response.body);
    print("searchTopicQuestionsFromJson");
    // print(json.runtimeType);
    return searchTopicQuestionsFromJson(response.body);
    // SearchTopicQuestions.fromJson(json);
  }
}
