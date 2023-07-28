import 'package:app/ebbe_ui/ebbe_ui.dart';
import 'package:app/oliver_ui.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: App()));

/*
* This is the main app widget.
* It contains two buttons that navigate to the two different UIs. 
* How it is currently being done is temporary but necessary for the sake of getting a runnable app.
*/

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
