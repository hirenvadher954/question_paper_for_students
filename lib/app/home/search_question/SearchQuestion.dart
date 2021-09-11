import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    textEditionController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${textEditionController.text}');
  }

  @override
  void dispose() {
    textEditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RegExp regExp = new RegExp(r"<[^>]*>");
    return BlocProvider<TopicQuestionsBloc>(
      create: (context) => TopicQuestionsBloc(repository: repository),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildSearchBar(),
                BlocBuilder<TopicQuestionsBloc, TopicQuestionsState>(
                  builder: (context, state) {
                    if (state is TopicQuestionsEmpty) {
                      BlocProvider.of<TopicQuestionsBloc>(context)
                          .add(FetchTopicQuestions());
                    }
                    if (state is TopicQuestionsError) {
                      return Center(
                        child: Text('failed to fetch quote'),
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
                            if (regExp.hasMatch(searchedQuestion)) {
                              searchedQuestion =
                                  searchedQuestion.replaceAll(regExp,"");
                            }

                            return Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: Colors.black38.withAlpha(10),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                child: AutoSizeText(searchedQuestion,
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: 15)));
                          },
                          itemCount: state.searchTopicQuestions.length,
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
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
        color: Colors.black38.withAlpha(10),
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
                hintText: "Search Paper Questions",
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
}
