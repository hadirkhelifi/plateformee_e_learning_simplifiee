import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/lesson.dart';
import '../../providers/lesson_provider.dart';

class LessonFormPage extends StatefulWidget {
  final Lesson? lesson;

  const LessonFormPage({super.key, this.lesson});

  @override
  State<LessonFormPage> createState() => _LessonFormPageState();
}

class _LessonFormPageState extends State<LessonFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.lesson?.title ?? '';
    _content = widget.lesson?.content ?? '';
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<LessonProvider>(context, listen: false);

      if (widget.lesson == null) {
        await provider.addLesson(_title, _content);
      } else {
        final updated = Lesson(
          id: widget.lesson!.id,
          title: _title,
          content: _content,
        );
        await provider.updateLesson(updated);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.lesson != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier la leçon' : 'Ajouter une leçon'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(labelText: 'Titre'),
                    validator: (value) =>
                        value!.isEmpty ? 'Le titre est requis.' : null,
                    onSaved: (value) => _title = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _content,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Contenu'),
                    validator: (value) =>
                        value!.isEmpty ? 'Le contenu est requis.' : null,
                    onSaved: (value) => _content = value!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    icon: const Icon(Icons.save),
                    label: Text(isEditing ? 'Modifier' : 'Ajouter'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
