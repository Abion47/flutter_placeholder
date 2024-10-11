import 'package:flutter/material.dart';

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

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: PlaceholderEx.lipsum(6, seed: seed),
        ),
      ),
    );
  }
}
