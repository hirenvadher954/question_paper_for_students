import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gtu_question_paper/app/home/selected_search_question/SelectedSearchQuesteion.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_question_repository.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_questions_api_client.dart';
import 'package:http/http.dart' as http;

import 'bloc/topic_questions_bloc.dart';

class SearchQuestion extends StatefulWidget {
  @override
  _SearchQuestionState createState() => _SearchQuestionState();
}

class _SearchQuestionState extends State<SearchQuestion> {
  final textEditionController = TextEditingController();
  final SearchTopicQuestionsRepository repository =
      SearchTopicQuestionsRepository(
          searchTopicQuestionsApiClient:
              SearchTopicQuestionsApiClient(httpClient: http.Client()));
  late TopicQuestionsBloc _topicQuestionsBloc =
      TopicQuestionsBloc(repository: repository);

  @override
  void initState() {
    super.initState();
    textEditionController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print("__printLatestValue ${textEditionController.text}");
    _topicQuestionsBloc
        .add(FetchTopicQuestions(query: textEditionController.text));
    // repository.fetchSearchQuestions(textEditionController.text);
  }

  @override
  void dispose() {
    textEditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RegExp htmlRegExp = RegExp(r"<[^>]*>");
    return BlocProvider<TopicQuestionsBloc>(
      create: (context) => _topicQuestionsBloc,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildSearchBar(),
                Divider(
                  thickness: 3,
                  // indent: 20,
                  // endIndent: 20,
                  color: Colors.blueGrey,
                  height: 20,
                ),
                BlocBuilder<TopicQuestionsBloc, TopicQuestionsState>(
                  builder: (context, state) {
                    if (state is TopicQuestionsEmpty) {
                      BlocProvider.of<TopicQuestionsBloc>(context).add(
                          FetchTopicQuestions(
                              query: textEditionController.text));
                    }
                    if (state is TopicQuestionsError) {
                      return Expanded(
                        child: Center(
                          child: Text('Failed to fetch questions'),
                        ),
                      );
                    }
                    if (state is TopicQuestionsLoaded) {
                      final listOfSearchTopicQuestions =
                          state.searchTopicQuestions;
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            String searchedQuestion = listOfSearchTopicQuestions
                                .elementAt(index)
                                .topicQuestion;
                            // if (htmlRegExp.hasMatch(searchedQuestion)) {
                            //   searchedQuestion =
                            //       searchedQuestion.replaceAll(htmlRegExp, "");
                            // }

                            searchedQuestion = searchedQuestion
                                .replaceAll('â', '"')
                                .replaceAll("â", '"');
                            return InkWell(
                                onTap: () => _gotoSelectedQuestion(
                                    listOfSearchTopicQuestions
                                        .elementAt(index)
                                        .topicId,
                                    listOfSearchTopicQuestions
                                        .elementAt(index)
                                        .qaId),
                                child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.black38.withAlpha(10),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      ),
                                    ),
                                    child: HtmlWidget(searchedQuestion))
                                // AutoSizeText(
                                //   searchedQuestion,
                                //   style: GoogleFonts.robotoCondensed(
                                //       fontSize: 17),
                                // )),
                                );
                          },
                          itemCount: state.searchTopicQuestions.length,
                        ),
                      );
                    }

                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildSearchBar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black38.withAlpha(30),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: true,
              controller: textEditionController,
              decoration: InputDecoration(
                hintText: "Search Paper Solutions",
                hintStyle: TextStyle(
                  color: Colors.black.withAlpha(120),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Colors.black.withAlpha(120),
          ),
        ],
      ),
    );
  }

  _gotoSelectedQuestion(int topicId, int qaId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectedSearchQuestion(
                  topicId: topicId,
                  qaId: qaId,
                )));
  }


}
