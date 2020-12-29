import 'package:flutter/material.dart';

import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> newScan(String valor) async {
    final ScanModel newScan = new ScanModel(valor: valor);
    final int id = await DBProvider.dbProvider.insertScan(newScan);
    newScan.id = id; // Asignar el id de la base de datos al modelo.
    
    if (this.tipoSeleccionado == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScan() async {
    final List<ScanModel> scans = await DBProvider.dbProvider.getAllScan();
    this.scans = [...scans];
    notifyListeners();
  }

  loadByTipoScan(String tipo) async {
    final List<ScanModel> scans = await DBProvider.dbProvider.getByTipoScan(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  deleteAllScan() async {
    await DBProvider.dbProvider.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteByIdScan(int id) async {
    await DBProvider.dbProvider.deleteScan(id);
    this.loadByTipoScan(this.tipoSeleccionado);
  }
}