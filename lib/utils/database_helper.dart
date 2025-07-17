import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../features/Home/data/flashcard_model.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  static Database? _db;

  LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'flashcards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            answer TEXT
          )
        ''');
      },
    );
  }

  Future<List<FlashcardModel>> getAllFlashcards() async {
    final db = await database;
    final result = await db.query('flashcards');
    return result.map((e) => FlashcardModel.fromMap(e)).toList();
  }

  Future<void> insertFlashcard(FlashcardModel model) async {
    final db = await database;
    await db.insert('flashcards', model.toMap());
  }

  Future<void> updateFlashcard(FlashcardModel model) async {
    final db = await database;
    await db.update('flashcards', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  Future<void> deleteFlashcard(int id) async {
    final db = await database;
    await db.delete('flashcards', where: 'id = ?', whereArgs: [id]);
  }
}
