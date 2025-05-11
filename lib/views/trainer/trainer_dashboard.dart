import 'package:flutter/material.dart';

class TrainerDashboard extends StatelessWidget {
  const TrainerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Formateur")),
      body: const Center(child: Text("Modules, Stats, Réussite...")),
    );
  }
}
