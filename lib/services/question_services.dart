import '../models/question.dart';
import '../database/question_db_helper.dart';

class QuestionService {
  Future<List<Question>> fetchQuestions() async {
    return await QuestionDbHelper().getQuestions();
  }

  Future<void> saveQuestion(Question question) async {
    await QuestionDbHelper().insertQuestion(question);
  }

  Future<void> deleteQuestion(String id) async {
    await QuestionDbHelper().deleteQuestion(id);
  }
}