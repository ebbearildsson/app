import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';

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
        tabBuilder: (BuildContext context, int index) => CupertinoTabView(builder: (BuildContext context) => [homepage(), foodpage(), workoutpage()][index]),
      ),
    );
  }

  Widget homepage() {
    return const CupertinoPageScaffold(child: Center(child: Text('home')));
  }

  Widget foodpage() {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 0,
                  sections: [
                    PieChartSectionData(color: CupertinoColors.systemRed, radius: 100, value: 40),
                    PieChartSectionData(color: CupertinoColors.systemGreen, radius: 100, value: 30),
                    PieChartSectionData(color: CupertinoColors.systemBlue, radius: 100, value: 15),
                    PieChartSectionData(color: CupertinoColors.systemYellow, radius: 100, value: 15),
                  ],
                ),
              ),
            ),
            const Text('Food'),
            CupertinoButton.filled(
              onPressed: () => print('pressed'),
              child: const Text('Add Food'),
            ),
          ],
        ),
      ),
    );
  }

  Widget workoutpage() {
    return const CupertinoPageScaffold(child: Center(child: Text('Workout')));
  }
}
