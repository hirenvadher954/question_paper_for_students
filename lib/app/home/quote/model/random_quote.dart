import 'package:equatable/equatable.dart';

class RandomQuote extends Equatable {
  late final String sId;
  late final List<String> tags;
  late final String content;
  late final String author;
  late final String authorSlug;
  late final int length;
  late final String dateAdded;
  late final String dateModified;

  RandomQuote(
      {required this.sId,
      required this.tags,
      required this.content,
      required this.author,
      required this.authorSlug,
      required this.length,
      required this.dateAdded,
      required this.dateModified});

  RandomQuote.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tags = json['tags'].cast<String>();
    content = json['content'];
    author = json['author'];
    authorSlug = json['authorSlug'];
    length = json['length'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  @override
  List<Object?> get props =>
      [sId, tags, content, author, authorSlug, length, dateAdded, dateModified];
}
