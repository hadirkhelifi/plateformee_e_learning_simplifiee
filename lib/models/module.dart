import 'package:plateforme_e_learning_simplifiee/models/lesson.dart';

class Module {
  final String id;
  final String title;
  final List<Lesson> lessons;

  Module({required this.id, required this.title, required this.lessons});
}