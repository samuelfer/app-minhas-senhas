import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MinhasSenhas());
}

// ignore: use_key_in_widget_constructors
class MinhasSenhas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minhas senhas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
