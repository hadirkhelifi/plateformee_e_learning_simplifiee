import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lesson_provider.dart';

import 'lesson_form_page.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des leçons'),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await lessonProvider.loadLessons(),
        child: FutureBuilder(
          future: lessonProvider.loadLessons(),
          builder: (ctx, snapshot) {
            if (lessonProvider.lessons.isEmpty) {
              return const Center(child: Text('Aucune leçon trouvée.'));
            }
            return ListView.builder(
              itemCount: lessonProvider.lessons.length,
              itemBuilder: (ctx, i) {
                final lesson = lessonProvider.lessons[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: ListTile(
                    title: Text(lesson.title),
                    subtitle: Text(
                      lesson.content.length > 50
                          ? '${lesson.content.substring(0, 50)}...'
                          : lesson.content,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LessonFormPage(lesson: lesson),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            lessonProvider.deleteLesson(lesson.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LessonFormPage()),
          );
        },
      ),
    );
  }
}
