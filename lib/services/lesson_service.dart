import '../models/lesson.dart';
import '../database/lesson_db_helper.dart';

class LessonService {
  final LessonDBHelper _dbHelper = LessonDBHelper();

  Future<void> addLesson(Lesson lesson) async {
    await _dbHelper.insertLesson(lesson);
  }

  Future<List<Lesson>> fetchLessons() async {
    return await _dbHelper.getAllLessons();
  }

  Future<void> updateLesson(Lesson lesson) async {
    await _dbHelper.updateLesson(lesson);
  }

  Future<void> deleteLesson(String id) async {
    await _dbHelper.deleteLesson(id);
  }
}
