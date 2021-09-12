import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/selected_search_question/bloc/selected_question_bloc.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_question_repository.dart';
import 'package:gtu_question_paper/repository/seach_topic_questions_repository/search_topic_questions_api_client.dart';
import 'package:http/http.dart' as http;

class SelectedSearchQuestion extends StatefulWidget {
  const SelectedSearchQuestion({required this.topicId, required this.qaId});

  final int topicId;
  final int qaId;

  @override
  _SelectedSearchQuestionState createState() => _SelectedSearchQuestionState();
}

class _SelectedSearchQuestionState extends State<SelectedSearchQuestion> {
  final SearchTopicQuestionsRepository repository =
      SearchTopicQuestionsRepository(
          searchTopicQuestionsApiClient:
              SearchTopicQuestionsApiClient(httpClient: http.Client()));
  late SelectedQuestionBloc _selectedQuestionBloc =
      SelectedQuestionBloc(repository: repository);

  @override
  void initState() {
    super.initState();
    // _selectedQuestionBloc
    //     .add(FetchSelectedQuestion(topicId: widget.topicId, qaId: widget.qaId));
  }

  @override
  Widget build(BuildContext context) {
    RegExp htmlRegExp = RegExp(r"<[^>]*>");
    return BlocProvider<SelectedQuestionBloc>(
      create: (context) => _selectedQuestionBloc,
      child: SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              BlocBuilder<SelectedQuestionBloc, SelectedQuestionState>(
                builder: (context, state) {
                  if (state is SelectedQuestionEmpty) {
                    BlocProvider.of<SelectedQuestionBloc>(context).add(
                        FetchSelectedQuestion(
                            topicId: widget.topicId, qaId: widget.qaId));
                  }
                  if (state is SelectedQuestionsError) {
                    return Expanded(
                      child: Center(
                        child: Text('Failed to fetch questions'),
                      ),
                    );
                  }
                  if (state is SelectedQuestionLoaded) {
                    final listOfSelectedQuestions = state.selectedTopicQuestion;

                    return Expanded(
                        child: ListView.builder(itemBuilder: (context, index) {
                      String topicQuestion = listOfSelectedQuestions
                          .elementAt(index)
                          .topicQuestion;
                      String topicAnswer =
                          listOfSelectedQuestions.elementAt(index).topicAnswer;

                      if (htmlRegExp.hasMatch(topicQuestion)) {
                        topicQuestion =
                            topicQuestion.replaceAll(htmlRegExp, "");
                      }

                      topicQuestion = removeUnwantedChar(topicQuestion);
                      topicAnswer = removeUnwantedChar(topicAnswer);
                      return Container(
                          child: Column(
                        children: [
                          Text("Q - " + topicQuestion,
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Html(data: topicAnswer, style: {
                            "table": Style(
                              backgroundColor:
                                  Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                            ),
                            "tr": Style(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            "th": Style(
                              padding: EdgeInsets.all(1),
                              backgroundColor: Colors.grey,
                            ),
                            // "td": Style(
                            //   padding: EdgeInsets.all(1),
                            //   alignment: Alignment.topLeft,
                            // ),
                            'h5': Style(
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis),
                          }, customRender: {
                            "table": (context, child) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: (context.tree as TableLayoutElement)
                                    .toWidget(context),
                              );
                            },
                          }),
                          Divider(
                            thickness: 3,
                            color: Colors.blueGrey,
                            height: 20,
                          ),
                        ],
                      ));
                    }));
                  }
                  return Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  String removeUnwantedChar(String html) {
    return html.replaceAll('â', '"').replaceAll("â", '"');
  }
}
