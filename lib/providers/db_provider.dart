import 'dart:io';

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
    final id = scanModel.id;
    final tipo = scanModel.tipo;
    final valor = scanModel.valor;
    
    // Verify database.
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor) VALUES ($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.insert('Scans', scanModel.toJson());
    
    // Ultimo ID del en la Tabla.
    return res;
  }
}
