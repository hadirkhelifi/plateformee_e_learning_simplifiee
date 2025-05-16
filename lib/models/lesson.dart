class Lesson {
  final String id;
  final String title;
  final String content; // Could be a video URL or text

  Lesson({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Lesson.fromMap(Map<String, dynamic> map, String id) {
    return Lesson(
      id: id,
      title: map['title'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
