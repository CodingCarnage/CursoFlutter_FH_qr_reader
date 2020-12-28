import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider dbProvider = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Obtener e path de la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int verison) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );
  }

  Future<int> newScanRaw(ScanModel scanModel) async {
    final int id = scanModel.id;
    final String tipo = scanModel.tipo;
    final String valor = scanModel.valor;
    
    // Verify database.
    final Database db = await database;

    final int res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor) VALUES ($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel scanModel) async {
    final Database db = await database;
    final int res = await db.insert('Scans', scanModel.toJson());
    
    // Ultimo ID del en la Tabla.
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScanAll() async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Scans');

    return res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  }

  Future<List<ScanModel>> getScanByTipo(String tipo) async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    return res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final Database db = await database;
    final int res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }
}
