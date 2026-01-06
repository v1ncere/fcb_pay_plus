import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  static final SqfliteService _instance = SqfliteService._internal();
  factory SqfliteService() => _instance;
  SqfliteService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_buttons (
        id TEXT PRIMARY KEY,
        backgroundColor TEXT NOT NULL,
        icon TEXT NOT NULL,
        iconColor TEXT NOT NULL,
        position INTEGER NOT NULL,
        title TEXT NOT NULL,
        titleColor TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE merchants (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        qrCode TEXT NOT NULL,
        tag TEXT NOT NULL,
        owner INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE qr_codes (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        data TEXT NOT NULL,
        widget TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY,
        accountNumber TEXT NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE pin_auth (
        id TEXT PRIMARY KEY,
        pin TEXT NOT NULL
      )
    ''');
  }
}