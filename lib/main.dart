import 'package:app/EbbeUI.dart';
import 'package:app/OliverUI.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App'),
        ),
        body: Column(
          children: [
            MaterialButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EbbeUI(),
                ),
              ),
              child: const Text('Ebbes Theme'),
            ),
            MaterialButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OliverUI(),
                ),
              ),
              child: const Text('Olivers Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
