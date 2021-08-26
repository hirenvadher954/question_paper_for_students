import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FindPaperEntity extends Equatable {
  const FindPaperEntity({required this.branchName, required this.imgSrc});

  final String branchName;
  final String imgSrc;

  Map<String, Object?> toJson() {
    return {'branchName': branchName, 'imgSrc': imgSrc};
  }

  @override
  List<Object?> get props => [branchName, imgSrc];

  @override
  String toString() {
    return 'FindPaperEntity {branchName:$branchName, imgSrc:$imgSrc}';
  }

  static FindPaperEntity fromJson(Map<String, Object> json) {
    return FindPaperEntity(
      branchName: json['branchName'] as String,
      imgSrc: json['imgSrc'] as String,
    );
  }

  static FindPaperEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as dynamic;
    if (data == null) throw Exception();
    return FindPaperEntity(
      branchName: data['branchName'],
      imgSrc: data['imgSrc'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'branchName': branchName,
      'imgSrc': imgSrc,
    };
  }
}
