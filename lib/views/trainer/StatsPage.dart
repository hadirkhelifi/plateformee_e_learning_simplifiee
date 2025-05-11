import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Statistiques de participation et de performance",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
