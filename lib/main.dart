import 'package:flutter/material.dart';
import 'package:maps_app/screens/screens.dart';

void main() => runApp(const MapsApp());

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: GpsAccessScreen(),
    );
  }
}