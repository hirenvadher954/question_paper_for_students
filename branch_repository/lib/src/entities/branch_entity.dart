import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BranchEntity extends Equatable {
  BranchEntity(
      {required this.id,
      required this.imgSrc,
      required this.branchName,
      required this.subjects});

  final String id;
  final String imgSrc;
  final String branchName;
  final List<String> subjects;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'imgSrc': imgSrc,
      'branchName': branchName,
      'subjects': subjects
    };
  }

  static BranchEntity fromJson(Map<String, Object> json) {
    return BranchEntity(
        id: json['id'] as String,
        imgSrc: json['imgSrc'] as String,
        branchName: json['branchName'] as String,
        subjects: json['subjects'] as List<String>);
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'imgSrc': imgSrc,
      'branchName': branchName,
      'subjects': subjects
    };
  }

  static BranchEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map;
    return BranchEntity(
        id: data['id'],
        imgSrc: data['imgSrc'],
        branchName: data['branchName'],
        subjects: data['subjects']);
  }

  @override
  String toString() {
    return 'Branch { imgSrc: $imgSrc, branchName: $branchName, }';
  }

  @override
  List<Object?> get props => [id, imgSrc, branchName, subjects];
}
