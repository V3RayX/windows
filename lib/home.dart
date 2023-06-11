// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is the home page :)'),
    );
  }
}
