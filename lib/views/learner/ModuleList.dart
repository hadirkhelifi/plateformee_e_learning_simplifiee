import 'package:flutter/material.dart';

class ModuleListPage extends StatelessWidget {
  const ModuleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "📚 Liste des modules (en cours & complétés)",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
