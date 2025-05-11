import 'package:flutter/material.dart';
import '../models/module.dart';
import '../services/course_service.dart';

class CourseProvider with ChangeNotifier {
  final CourseService _courseService = CourseService();
  List<Module> _modules = [];

  List<Module> get modules => _modules;

  Future<void> loadModules() async {
    _modules = await _courseService.fetchModules();
    notifyListeners();
  }
}