import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';

class LessonProvider with ChangeNotifier {
  final LessonService _service = LessonService();
  List<Lesson> _lessons = [];

  List<Lesson> get lessons => _lessons;

  Future<void> loadLessons() async {
    _lessons = await _service.fetchLessons();
    notifyListeners();
  }

  Future<void> addLesson(String title, String content) async {
    final newLesson = Lesson(
      id: const Uuid().v4(), // Génère un ID unique
      title: title,
      content: content,
    );
    await _service.addLesson(newLesson);
    _lessons.add(newLesson);
    notifyListeners();
  }

  Future<void> updateLesson(Lesson updatedLesson) async {
    await _service.updateLesson(updatedLesson);
    final index = _lessons.indexWhere((l) => l.id == updatedLesson.id);
    if (index != -1) {
      _lessons[index] = updatedLesson;
      notifyListeners();
    }
  }

  Future<void> deleteLesson(String id) async {
    await _service.deleteLesson(id);
    _lessons.removeWhere((l) => l.id == id);
    notifyListeners();
  }
}
