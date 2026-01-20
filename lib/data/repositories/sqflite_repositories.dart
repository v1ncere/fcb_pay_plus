import 'package:sqflite/sqflite.dart';

import '../data.dart';

class SqfliteRepositories {
  final SqfliteService _db;

  SqfliteRepositories({required SqfliteService sqfliteService}) : _db = sqfliteService;

  //* PINAUTH ====================
  Future<void> insertPinAuth(PinAuth pinAuth) async {
    final db = await _db.database;
    await db.insert(
      'pin_auth',
      pinAuth.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PinAuth?> getPinAuthById(String id) async {
    final db = await _db.database;
    final result = await db.query(
      'pin_auth',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return PinAuth.fromMap(result.first);
  }

  Future<List<PinAuth>> getAllPinAuth() async {
    final db = await _db.database;
    final result = await db.query('pin_auth');
    return result.map(PinAuth.fromMap).toList();
  }

  Future<void> deletePinAuth(String id) async {
    final db = await _db.database;
    await db.delete(
      'pin_auth',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

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
  // save account type which be displayed first in the accounts tab
  Future<void> insertAccount(Accounts account) async {
    final db = await _db.database;
    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Accounts?> getAccountById(String id) async { // get the account by [type]
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

  // FAVORITE BUTTONS
  Future<void> insertFavoriteButton(FavoriteButton favorite) async {
    final db = await _db.database;
    await db.insert(
      'favorite_buttons',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<FavoriteButton?> getFavoritesById(String id) async {
    final db = await _db.database;
    final result = await db.query(
      'favorite_buttons',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return FavoriteButton.fromMap(result.first);
  }

  Future<List<FavoriteButton>> getAllFavorites() async {
    final db = await _db.database;
    final result = await db.query('favorite_buttons');
    return result.map(FavoriteButton.fromMap).toList();
  }

  Future<void> deleteFavorite(String id) async {
    final db = await _db.database;
    await db.delete(
      'favorite_buttons',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}