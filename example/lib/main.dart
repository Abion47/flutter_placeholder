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
          body: LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 300,
                  height: 500,
                  child: ShadowText.words(
                    seed: seed,
                    shadowHeight: 12,
                    cornerRadius: 4,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
