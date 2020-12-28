import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';

class HistorialMapasPage extends StatelessWidget {
  const HistorialMapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, int i) => ListTile(
        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
        title: Text(scans[i].valor),
        subtitle: Text('Id: ${scans[i].id.toString()}'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => print('Hacer algo'),
      ),
    );
  }
}
