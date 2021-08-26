import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtu_question_paper/repository/find_paper/entities/find_paper_entity.dart';
import 'package:gtu_question_paper/repository/find_paper/find_paper_repository.dart';
import 'package:gtu_question_paper/repository/find_paper/models/FindPaper.dart';

class FirebaseFindPaperRepository implements FindPaperRepository {
  final findPaperCollection =
      FirebaseFirestore.instance.collection('branchList');

  @override
  Stream<List<FindPaper>> paperList() {
    return findPaperCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => FindPaper.fromEntity(
              FindPaperEntity.fromSnapshot(doc),
            ))
        .toList());
  }
}
