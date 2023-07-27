import 'package:app/EbbeUI.dart';
import 'package:app/OliverUI.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: App()));

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EbbeUI())),
            child: const Text('Ebbes Theme'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OliverUI())),
            child: const Text('Olivers Theme'),
          ),
        ],
      ),
    );
  }
}
