import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/repository/find_paper/models/Semester.dart';

class FindPaperEntity extends Equatable {
  const FindPaperEntity(
      {required this.branchName, required this.imgSrc, required this.semester});

  final String branchName;
  final String imgSrc;
  final Map<String, dynamic> semester;

  Map<String, Object?> toJson() {
    return {'branchName': branchName, 'imgSrc': imgSrc, 'semesters': semester};
  }

  @override
  List<Object?> get props => [branchName, imgSrc, semester];

  @override
  String toString() {
    return 'FindPaperEntity {branchName:$branchName, imgSrc:$imgSrc}';
  }

  static FindPaperEntity fromJson(Map<String, Object> json) {
    return FindPaperEntity(
        branchName: json['branchName'] as String,
        imgSrc: json['imgSrc'] as String,
        semester: json['semester'] as Map<String, dynamic>);
  }

  static FindPaperEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as dynamic;
    if (data == null) throw Exception();
    return FindPaperEntity(
        branchName: data['branchName'],
        imgSrc: data['imgSrc'],
        semester: Map<String, dynamic>.from(data['semester']));
  }

  Map<String, Object?> toDocument() {
    return {'branchName': branchName, 'imgSrc': imgSrc, 'semester': semester};
  }
}
