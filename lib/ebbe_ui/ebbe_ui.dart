import 'package:app/ebbe_ui/foodpage.dart';
import 'package:flutter/cupertino.dart';

class EbbeUI extends StatelessWidget {
  const EbbeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Ebbes',
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_list), label: 'Food'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Workout'),
          ],
        ),
        tabBuilder: (BuildContext context, int index) => CupertinoTabView(builder: (BuildContext context) => [homepage(), const FoodPage(), workoutpage()][index]),
      ),
    );
  }

  Widget homepage() {
    return const CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(middle: Text('Home')), child: Center(child: Text('home')));
  }

  Widget workoutpage() {
    return const CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(middle: Text('Workout Tracker')), child: Center(child: Text('Workout')));
  }
}
