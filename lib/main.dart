import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 255, 152, 0),
          primaryColorDark: Color.fromARGB(255, 245, 124, 0),
          primaryColorLight: Color.fromARGB(255, 255, 224, 178),
          accentColor: Color.fromARGB(255, 76, 175, 80),
          // Cambia el color del Texto que este sobre mi PrimaryColor a blanco.
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          // Cambia el color de los iconos que esten sobre mi PrimaryColor a blanco.
          primaryIconTheme: IconThemeData(color: Colors.white),
          // Cambia el color de los iconos del status bar a blanco.
          appBarTheme: AppBarTheme(brightness: Brightness.dark),
          fontFamily: 'Poppins',
        ),
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
      ),
    );
  }
}
