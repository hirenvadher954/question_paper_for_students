import 'package:gtu_question_paper/repository/notes_section/entities/notes_entity.dart';

class Notes {
  final String imgSrc;
  final String name;
  final String pdfLink;

  Notes({required this.imgSrc, required this.name, required this.pdfLink});

  static Notes fromEntity(NotesEntity entity) {
    return Notes(
        name: entity.name, imgSrc: entity.imgSrc, pdfLink: entity.pdfLink);
  }
}
