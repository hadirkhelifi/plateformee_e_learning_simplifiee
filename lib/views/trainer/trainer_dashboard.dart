import 'package:flutter/material.dart';
import 'package:plateforme_e_learning_simplifiee/views/trainer/CourseBuilder.dart';
import 'package:plateforme_e_learning_simplifiee/views/trainer/StatsPage.dart';
import 'package:plateforme_e_learning_simplifiee/views/trainer/LearnersPage.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({super.key});

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CourseBuilderPage(),
    StatsPage(),
    LearnersPage(),
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
        title: const Text("Espace Formateur"),
        backgroundColor: Colors.blue[800],
        actions: [
          TextButton(
            onPressed: () => _onItemTapped(0),
            child: const Text("CourseBuilder", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(1),
            child: const Text("Statistiques", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(2),
            child: const Text("Apprenants", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}

