import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lesson.dart';

class LessonDBHelper {
  static final LessonDBHelper _instance = LessonDBHelper._internal();
  factory LessonDBHelper() => _instance;
  LessonDBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'lesson.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE lessons(
            id TEXT PRIMARY KEY,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLesson(Lesson lesson) async {
    final db = await database;
    await db.insert(
      'lessons',
      {'id': lesson.id, ...lesson.toMap()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Lesson>> getAllLessons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('lessons');

    return List.generate(maps.length, (i) {
      return Lesson.fromMap(maps[i], maps[i]['id']);
    });
  }

  Future<void> updateLesson(Lesson lesson) async {
    final db = await database;
    await db.update(
      'lessons',
      lesson.toMap(),
      where: 'id = ?',
      whereArgs: [lesson.id],
    );
  }

  Future<void> deleteLesson(String id) async {
    final db = await database;
    await db.delete(
      'lessons',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
