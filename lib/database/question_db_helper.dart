
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/question.dart';

class QuestionDbHelper {
  static final QuestionDbHelper _instance = QuestionDbHelper._internal();
  factory QuestionDbHelper() => _instance;
  QuestionDbHelper._internal();

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
          CREATE TABLE questions (
            id TEXT PRIMARY KEY,
            questionText TEXT,
            correctIndex INTEGER,
            isMultipleChoice INTEGER,
            answers TEXT
          )
        ''');
      },
    );
  }

  Future<List<Question>> getQuestions() async {
    final dbClient = await db;
    final maps = await dbClient.query('questions');
    return maps.map((map) => Question.fromMap(map, map['id'] as String)).toList();
  }

  Future<void> insertQuestion(Question question) async {
    final dbClient = await db;
    await dbClient.insert('questions', {
      'id': question.id,
      ...question.toMap(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateQuestion(Question question) async {
    final dbClient = await db;
    await dbClient.update(
      'questions',
      question.toMap(),
      where: 'id = ?',
      whereArgs: [question.id],
    );
  }

  Future<void> deleteQuestion(String id) async {
    final dbClient = await db;
    await dbClient.delete('questions', where: 'id = ?', whereArgs: [id]);
  }
}