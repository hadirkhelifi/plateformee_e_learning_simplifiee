
 import 'package:plateforme_e_learning_simplifiee/models/answer.dart';


class Question {
  final String id;
  final String questionText;
  final List<Answer> answers;
  final int correctIndex;
  final bool isMultipleChoice;

  Question({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctIndex,
    this.isMultipleChoice = false,
  });

  factory Question.fromMap(Map<String, dynamic> map, String id) {
  return Question(
    id: id,
    questionText: map['questionText'],
    correctIndex: map['correctIndex'],
    isMultipleChoice: map['isMultipleChoice'] == 1,
    answers: Answer.fromJsonList(map['answers']), // ✅ ici
  );
}

Map<String, dynamic> toMap() {
  return {
    'questionText': questionText,
    'correctIndex': correctIndex,
    'isMultipleChoice': isMultipleChoice ? 1 : 0,
    'answers': Answer.toJsonList(answers), // ✅ ici
  };
}

}
