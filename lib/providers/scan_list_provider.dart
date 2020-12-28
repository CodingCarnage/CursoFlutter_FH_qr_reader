import 'package:flutter/material.dart';

import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  newScan(String valor) async {
    final ScanModel newScan = new ScanModel(valor: valor);
    final int id = await DBProvider.dbProvider.insertScan(newScan);
    newScan.id = id; // Asignar el id de la base de datos al modelo.
    
    if (this.tipoSeleccionado == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }
  }
}