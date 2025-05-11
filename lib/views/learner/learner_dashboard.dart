import 'package:flutter/material.dart';

class LearnerDashboard extends StatelessWidget {
  const LearnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Apprenant")),
      body: const Center(child: Text("Liste des modules, progrès, résultats...")),
    );
  }
}
