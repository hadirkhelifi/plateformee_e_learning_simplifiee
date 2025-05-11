import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/quiz_service.dart';

class QuizProvider with ChangeNotifier {
  final QuizService _quizService = QuizService();
  List<Quiz> _quizzes = [];

  List<Quiz> get quizzes => _quizzes;

  Future<void> loadQuizzes(String moduleId) async {
    _quizzes = await _quizService.fetchQuizzes(moduleId);
    notifyListeners();
  }
}
