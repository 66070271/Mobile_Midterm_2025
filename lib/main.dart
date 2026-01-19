import 'package:flutter/material.dart';
import 'package:mock4/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo',
      theme: ThemeData(primarySwatch: Colors.blueGrey,useMaterial3: false),
      home: HomeScreen()
    );
  }
}
