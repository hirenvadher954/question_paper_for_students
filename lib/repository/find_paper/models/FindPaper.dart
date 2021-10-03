import 'package:gtu_question_paper/repository/find_paper/entities/find_paper_entity.dart';

class FindPaper {
  FindPaper(
      {required this.branchName, required this.imgSrc, required this.semester});

  final String branchName;
  final String imgSrc;
  Map<String, dynamic> semester;

  // FindPaper copyWith({String? branchName, String? imgSrc}) {
  //   return FindPaper(
  //     branchName: branchName ?? this.branchName,
  //     imgSrc: imgSrc ?? this.imgSrc,
  //   );
  // }

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //       other is FindPaper &&
  //           runtimeType == other.runtimeType &&
  //           branchName == other.branchName &&
  //           imgSrc == other.imgSrc;
  // }

  // @override
  // int get hashCode => branchName.hashCode ^ imgSrc.hashCode;

  // @override
  // String toString() {
  //   return 'FindPaper{branchName: $branchName, imgSrc: $imgSrc}';
  // }

  FindPaperEntity toEntity() {
    return FindPaperEntity(
      branchName: branchName,
      imgSrc: imgSrc,
      semester: semester,
    );
  }

  static FindPaper fromEntity(FindPaperEntity entity) {
    return FindPaper(
        branchName: entity.branchName,
        imgSrc: entity.imgSrc,
        semester: entity.semester);
  }
}
