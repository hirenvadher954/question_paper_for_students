class Semester {
  Semester({
    required this.subjects,
  });

  List<dynamic> subjects;

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        subjects: List<String>.from(json["subjects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
      };
}
