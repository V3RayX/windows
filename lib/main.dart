// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const V3ray());
}

class V3ray extends StatefulWidget {
  const V3ray({super.key});

  @override
  State<V3ray> createState() => _V3rayState();
}

class _V3rayState extends State<V3ray> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
