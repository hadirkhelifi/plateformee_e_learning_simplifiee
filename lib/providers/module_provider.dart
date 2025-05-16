import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/module.dart';
import '../database/module_db_helper.dart';

class ModuleProvider with ChangeNotifier {
  List<Module> _modules = [];
  final _dbHelper = ModuleDbHelper();

  List<Module> get modules => _modules;

  Future<void> fetchModules() async {
    _modules = await _dbHelper.getModules();
    notifyListeners();
  }

  Future<void> addModule(String title) async {
    final newModule = Module(id: const Uuid().v4(), title: title);
    await _dbHelper.insertModule(newModule);
    _modules.add(newModule);
    notifyListeners();
  }

  Future<void> updateModule(Module updatedModule) async {
    await _dbHelper.updateModule(updatedModule);
    final index = _modules.indexWhere((m) => m.id == updatedModule.id);
    if (index != -1) {
      _modules[index] = updatedModule;
      notifyListeners();
    }
  }

  Future<void> deleteModule(String id) async {
    await _dbHelper.deleteModule(id);
    _modules.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}