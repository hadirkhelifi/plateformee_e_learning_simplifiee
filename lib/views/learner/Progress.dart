import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "📈 Suivi de l'avancement par module",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
