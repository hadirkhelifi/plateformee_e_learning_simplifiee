import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/module.dart';
import '../../providers/module_provider.dart';

class ModuleFormPage extends StatefulWidget {
  final Module? module;

  const ModuleFormPage({super.key, this.module});

  @override
  State<ModuleFormPage> createState() => _ModuleFormPageState();
}

class _ModuleFormPageState extends State<ModuleFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.module?.title ?? '';
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<ModuleProvider>(context, listen: false);

      if (widget.module == null) {
        await provider.addModule(_title);
      } else {
        final updated = Module(id: widget.module!.id, title: _title);
        await provider.updateModule(updated);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.module != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier le module' : 'Ajouter un module'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(labelText: 'Titre du module'),
                    validator: (value) =>
                        value!.isEmpty ? 'Le titre est requis.' : null,
                    onSaved: (value) => _title = value!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    icon: const Icon(Icons.save),
                    label: Text(isEditing ? 'Modifier' : 'Ajouter'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
