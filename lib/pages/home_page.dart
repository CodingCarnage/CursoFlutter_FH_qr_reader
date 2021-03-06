import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/widgets/custom_navigationbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import 'package:qr_reader/pages/historial_mapas_page.dart';
import 'package:qr_reader/pages/direcciones_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              final ScanListProvider scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.deleteAllScan();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UiProvider uiProvider = Provider.of<UiProvider>(context);

    final int currentIndex = uiProvider.selectedMenuOption;

    switch (currentIndex) {
      case 0:
        return HistorialMapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
        return HistorialMapasPage();
    }
  }
}
