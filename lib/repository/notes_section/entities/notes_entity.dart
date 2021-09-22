import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotesEntity extends Equatable {
  final String imgSrc;
  final String name;
  final String pdfLink;

  NotesEntity(
      {required this.imgSrc, required this.name, required this.pdfLink});

  Map<String, Object?> toJson() {
    return {'imgSrc': imgSrc, 'name': name, 'pdfLink': pdfLink};
  }

  @override
  List<Object?> get props => [imgSrc, name, pdfLink];

  @override
  String toString() {
    return 'NotesEntity {imgSrc:$imgSrc, name:$name}';
  }

  static NotesEntity fromJson(Map<String, Object> json) {
    return NotesEntity(
        imgSrc: json['imgSrc'] as String,
        name: json['name'] as String,
        pdfLink: json['pdfLink'] as String);
  }

  static NotesEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as dynamic;
    if (data == null) throw Exception();
    return NotesEntity(
        imgSrc: data['imgSrc'], name: data['name'], pdfLink: data['pdfLink']);
  }

  Map<String, Object?> toDocument() {
    return {'imgSrc': imgSrc, 'name': name, 'pdfLink': pdfLink};
  }
}
