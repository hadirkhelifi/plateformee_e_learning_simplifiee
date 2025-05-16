import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/module_provider.dart';
import 'module_form_page.dart';

class ModuleListPage extends StatelessWidget {
  const ModuleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des modules"), backgroundColor: Colors.blue),
      body: FutureBuilder(
        future: Provider.of<ModuleProvider>(context, listen: false).fetchModules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<ModuleProvider>(
            builder: (context, provider, _) => ListView.builder(
              itemCount: provider.modules.length,
              itemBuilder: (context, index) {
                final module = provider.modules[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(module.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ModuleFormPage(module: module),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => Provider.of<ModuleProvider>(context, listen: false)
                              .deleteModule(module.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ModuleFormPage()),
        ),
      ),
    );
  }
}