import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/question_provider.dart';


class QuestionListPage extends StatelessWidget {
  const QuestionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Questions'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: questionProvider.loadQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (questionProvider.questions.isEmpty) {
            return const Center(child: Text("Aucune question trouvée."));
          }
          return ListView.builder(
            itemCount: questionProvider.questions.length,
            itemBuilder: (context, index) {
              final question = questionProvider.questions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                child: ListTile(
                  title: Text(question.questionText),
                  subtitle: Text(
                    question.isMultipleChoice ? 'Choix multiple' : 'Choix unique',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // TODO : Naviguer vers la page d'édition
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          questionProvider.deleteQuestion(question.id);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO : Naviguer vers le formulaire d'ajout
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
