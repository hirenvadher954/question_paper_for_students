import 'dart:async';

import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

abstract class FindPaperRepository {
  Stream<List<FindPaper>> paperList();
}
