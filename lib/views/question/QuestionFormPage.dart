import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/question.dart';
import '../../models/answer.dart';
import '../../providers/question_provider.dart';

class QuestionFormPage extends StatefulWidget {
  final Question? question; // null si ajout

  const QuestionFormPage({super.key, this.question});

  @override
  State<QuestionFormPage> createState() => _QuestionFormPageState();
}

class _QuestionFormPageState extends State<QuestionFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late List<TextEditingController> _answerControllers;
  int _correctIndex = 0;
  bool _isMultipleChoice = false;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
        text: widget.question != null ? widget.question!.questionText : '');
    _answerControllers = List.generate(4, (index) {
      if (widget.question != null && index < widget.question!.answers.length) {
        return TextEditingController(text: widget.question!.answers[index].text);
      }
      return TextEditingController();
    });
    _correctIndex = widget.question?.correctIndex ?? 0;
    _isMultipleChoice = widget.question?.isMultipleChoice ?? false;
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveQuestion() {
    if (_formKey.currentState!.validate()) {
      final questionText = _questionController.text;
      final answers = _answerControllers.map((c) => Answer(text: c.text)).toList();

      final question = Question(
        id: widget.question?.id ?? const Uuid().v4(),
        questionText: questionText,
        answers: answers,
        correctIndex: _correctIndex,
        isMultipleChoice: _isMultipleChoice,
      );

      final provider = Provider.of<QuestionProvider>(context, listen: false);

      if (widget.question == null) {
        provider.addQuestion(
          question.questionText,
          question.answers,
          question.correctIndex,
          question.isMultipleChoice,
        );
      } else {
        provider.updateQuestion(question);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.question != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier Question' : 'Ajouter Question'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Texte de la question'),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer la question' : null,
              ),
              const SizedBox(height: 16),
              ...List.generate(4, (index) {
                return TextFormField(
                  controller: _answerControllers[index],
                  decoration: InputDecoration(labelText: 'Réponse ${index + 1}'),
                  validator: (value) => value!.isEmpty ? 'Veuillez entrer une réponse' : null,
                );
              }),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _correctIndex,
                decoration: const InputDecoration(labelText: 'Bonne réponse'),
                items: List.generate(4, (index) {
                  return DropdownMenuItem(value: index, child: Text('Réponse ${index + 1}'));
                }),
                onChanged: (val) => setState(() => _correctIndex = val!),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Question à choix multiple'),
                value: _isMultipleChoice,
                onChanged: (val) => setState(() => _isMultipleChoice = val),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(isEditing ? 'Enregistrer' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
