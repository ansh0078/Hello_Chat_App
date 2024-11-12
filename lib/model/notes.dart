class Note {
  Note({
    // required this.id,
    required this.title,
    required this.content,
    required this.contentJson,
    required this.dateCreated,
    required this.dateModified,
    required this.tags,
  });

  // final String? id;
  final String? title;
  final String? content;
  final String contentJson;
  final int dateCreated;
  final int dateModified;
  final List<String>? tags;
}
