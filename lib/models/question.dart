
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
}