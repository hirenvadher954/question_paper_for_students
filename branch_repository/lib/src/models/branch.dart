import 'package:flutter/foundation.dart';
import 'package:subject_repository/src/entities/entities.dart';

@immutable
class Branch {
  Branch(
      {required this.id,
      required this.imgSrc,
      required this.branchName,
      required this.subjects});

  final String id;
  final String imgSrc;
  final String branchName;
  final List<String> subjects;

  static Branch fromEntity(BranchEntity entity) {
    return Branch(
        id: entity.id,
        imgSrc: entity.imgSrc,
        branchName: entity.branchName,
        subjects: entity.subjects);
  }

  @override
  String toString() {
    return 'Branch{imgSrc: $imgSrc, name: $branchName}';
  }
}
