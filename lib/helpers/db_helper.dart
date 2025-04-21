import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/profile_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> _getDb() async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'profile.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE profile(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            nim TEXT,
            fakultas TEXT,
            prodi TEXT,
            alamat TEXT,
            hp TEXT,
            fotoPath TEXT
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<int> insertProfile(Profile profile) async {
    final db = await _getDb();
    return await db.insert('profile', profile.toMap());
  }

  static Future<Profile?> getProfileById(int id) async {
    final db = await _getDb();
    final result = await db.query(
      'profile',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Profile.fromMap(result.first);
    }
    return null;
  }
}
