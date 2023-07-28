import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  DateTime date = DateTime(2016, 10, 26);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(child: const Icon(CupertinoIcons.left_chevron), onPressed: () => setState(() => date = date.subtract(const Duration(days: 1)))),
                CupertinoButton(
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: date,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      showDayOfWeek: true,
                      onDateTimeChanged: (DateTime newDate) => setState(() => date = newDate),
                    ),
                  ),
                  child: Text(DateFormat('dd/MM/yy').format(date)),
                ),
                CupertinoButton(child: const Icon(CupertinoIcons.right_chevron), onPressed: () => setState(() => date = date.add(const Duration(days: 1)))),
              ],
            ),
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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}
