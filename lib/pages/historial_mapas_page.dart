import 'package:flutter/material.dart';

class HistorialMapasPage extends StatelessWidget {
  const HistorialMapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, int i) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: Text('https://www.google.com'),
        subtitle: Text('ID: 1'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => print('Hacer algo'),
      ),
    );
  }
}
