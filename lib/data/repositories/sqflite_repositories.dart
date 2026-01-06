import 'package:sqflite/sqflite.dart';

import '../data.dart';

class SqfliteRepositories {
  final SqfliteService _db;

  SqfliteRepositories({required SqfliteService sqfliteService}) : _db = sqfliteService;

  //* MERCHANTS ====================
  Future<void> insertMerchant(Merchant merchant) async {
    final db = await _db.database;
    await db.insert(
      'merchants',
      merchant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Merchant?> getMerchantById(String id) async {
    final db = await _db.database;
    final result = await db.query(
      'merchants',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Merchant.fromMap(result.first);
  }

  Future<List<Merchant>> getAllMerchants() async {
    final db = await _db.database;
    final result = await db.query('merchants');
    return result.map(Merchant.fromMap).toList();
  }

  Future<void> deleteMerchant(String id) async {
    final db = await _db.database;
    await db.delete(
      'merchants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //* QR ====================
  Future<void> insertQr(QrData qr) async {
    final db = await _db.database;
    await db.insert(
      'qr_codes',
      qr.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<QrData>> getQrsById(String id) async {
    final db = await _db.database;
    final result = await db.query(
      'qr_codes',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.map(QrData.fromMap).toList();
  }

  //* ACCOUNT ====================
  Future<void> insertAccount(Accounts account) async {
    final db = await _db.database;
    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Accounts?> getAccountById(String id) async {
    final db = await _db.database;
    final result = await db.query(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Accounts.fromMap(result.first);
  }

  Future<List<Accounts>> getAllAccounts() async {
    final db = await _db.database;
    final result = await db.query('accounts');
    return result.map(Accounts.fromMap).toList();
  }

  Future<void> deleteAccount(String id) async {
    final db = await _db.database;
    await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}