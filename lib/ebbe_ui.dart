import 'package:flutter/cupertino.dart';

class EbbeUI extends StatelessWidget {
  const EbbeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Ebbes',
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Ebbes'),
        ),
        child: Container(),
      ),
    );
  }
}
