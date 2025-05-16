import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/module.dart';

class ModuleDbHelper {
  static final ModuleDbHelper _instance = ModuleDbHelper._internal();
  factory ModuleDbHelper() => _instance;
  ModuleDbHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'elearning.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE modules (
            id TEXT PRIMARY KEY,
            title TEXT
          )
        ''');
      },
    );
  }

  Future<List<Module>> getModules() async {
    final dbClient = await db;
    final maps = await dbClient.query('modules');
    return maps.map((map) => Module.fromMap(map, map['id'] as String)).toList();
  }

  Future<void> insertModule(Module module) async {
    final dbClient = await db;
    await dbClient.insert('modules', module.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateModule(Module module) async {
    final dbClient = await db;
    await dbClient.update(
      'modules',
      module.toMap(),
      where: 'id = ?',
      whereArgs: [module.id],
    );
  }

  Future<void> deleteModule(String id) async {
    final dbClient = await db;
    await dbClient.delete('modules', where: 'id = ?', whereArgs: [id]);
  }
}
