import 'package:flutter/material.dart';

import 'sandbox.dart';

import 'package:flutter_placeholder/flutter_placeholder.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  late Lipsum lipsum;

  MainApp({super.key}) {
    lipsum = Lipsum();
  }

  @override
  Widget build(BuildContext context) {
    const seed = 50;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: PlaceholderImage.scaffold()),
                Expanded(child: PlaceholderImage.gradient()),
                Expanded(child: PlaceholderImage.checkerboard()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
