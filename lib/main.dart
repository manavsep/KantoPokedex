import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kantopokedex/pages/pokedex_page.dart';

Future<void> main() async{
  await Hive.initFlutter();
  await Hive.openBox("pokedex");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokedexPage(),
    );
  }

}

