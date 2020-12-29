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
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          padding: const EdgeInsets.only(left: 5.0),
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete, size: 30.0, color: Colors.white),
        ),
        onDismissed: (DismissDirection direction) => Provider.of<ScanListProvider>(context, listen: false).deleteByIdScan(scans[i].id),
        direction: DismissDirection.startToEnd,
        child: ListTile(
          leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
          title: Text(scans[i].valor),
          subtitle: Text('Id: ${scans[i].id.toString()}'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print('Hacer algo'),
        ),
      ),
    );
  }
}
