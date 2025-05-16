import 'dart:convert';

class Answer {
  final String text;

  Answer({required this.text});

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(text: map['text']);
  }

  Map<String, dynamic> toMap() {
    return {'text': text};
  }

  static List<Answer> fromJsonList(String jsonList) {
    final List<dynamic> decoded = jsonDecode(jsonList);
    return decoded.map((e) => Answer.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  static String toJsonList(List<Answer> answers) {
    final mapped = answers.map((e) => e.toMap()).toList();
    return jsonEncode(mapped);
  }
}