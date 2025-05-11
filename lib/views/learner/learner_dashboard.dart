import 'package:flutter/material.dart';
import 'package:plateforme_e_learning_simplifiee/views/learner/ModuleList.dart';
import 'package:plateforme_e_learning_simplifiee/views/learner/QuizPage.dart';
import 'package:plateforme_e_learning_simplifiee/views/learner/Progress.dart';

class LearnerDashboard extends StatefulWidget {
  const LearnerDashboard({super.key});

  @override
  State<LearnerDashboard> createState() => _LearnerDashboardState();
}

class _LearnerDashboardState extends State<LearnerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ModuleListPage(),
    QuizPage(),
    ProgressPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Espace Apprenant"),
        backgroundColor: Colors.blue[800],
        actions: [
          TextButton(
            onPressed: () => _onItemTapped(0),
            child: const Text("Modules", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(1),
            child: const Text("Quiz", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(2),
            child: const Text("Progression", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
