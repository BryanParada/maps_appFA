import 'package:flutter/material.dart';

void main() => runApp(const MapsApp());

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: Scaffold(
        body: Center(
          child: Text('hi')
        )
      ),
    );
  }
}