import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key key, @required this.tipo}) : super(key: key);

  final String tipo;

  @override
  Widget build(BuildContext context) {
    final ScanListProvider scanListProvider =
        Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    this.tipo == 'http'
        ? scanListProvider.loadByTipoScan('http')
        : scanListProvider.loadByTipoScan('geo');

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          padding: const EdgeInsets.only(left: 10.0),
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete, size: 30.0, color: Colors.white),
        ),
        onDismissed: (DismissDirection direction) =>
            Provider.of<ScanListProvider>(context, listen: false)
                .deleteByIdScan(scans[i].id),
        direction: DismissDirection.startToEnd,
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.http : Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text('Id: ${scans[i].id.toString()}'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}
