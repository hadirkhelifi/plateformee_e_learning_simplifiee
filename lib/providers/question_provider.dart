import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/question.dart';
import '../database/question_db_helper.dart';
import '../models/answer.dart';

class QuestionProvider with ChangeNotifier {
  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  Future<void> loadQuestions() async {
    _questions.clear();
    _questions.addAll(await QuestionDbHelper().getQuestions());
    notifyListeners();
  }

  Future<void> addQuestion(String text, List<Answer> answers, int correctIndex, bool isMultipleChoice)
async {
    final newQuestion = Question(
      id: const Uuid().v4(),
      questionText: text,
      answers: answers,
      correctIndex: correctIndex,
      isMultipleChoice: isMultipleChoice,
    );
    await QuestionDbHelper().insertQuestion(newQuestion);
    _questions.add(newQuestion);
    notifyListeners();
  }

  Future<void> updateQuestion(Question updated) async {
    await QuestionDbHelper().updateQuestion(updated);
    final index = _questions.indexWhere((q) => q.id == updated.id);
    if (index != -1) {
      _questions[index] = updated;
      notifyListeners();
    }
  }

  Future<void> deleteQuestion(String id) async {
    await QuestionDbHelper().deleteQuestion(id);
    _questions.removeWhere((q) => q.id == id);
    notifyListeners();
  }
}
