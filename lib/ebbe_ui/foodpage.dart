import 'package:app/controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

enum addTypes { hundred, total, meal }

class _FoodPageState extends State<FoodPage> {
  EbbesController controller = EbbesController();
  DateTime date = DateTime(2023, 7, 28);

  Map<addTypes, Color> skyColors = <addTypes, Color>{
    addTypes.hundred: const Color(0xff191970),
    addTypes.total: const Color(0xff40826d),
    addTypes.meal: const Color(0xff007ba7),
  };

  var _selectedSegment = addTypes.hundred;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Food Tracker')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(child: const Icon(CupertinoIcons.left_chevron), onPressed: () => setState(() => date = date.subtract(const Duration(days: 1)))),
                CupertinoButton(onPressed: () => _showDatePicker(context), child: Text(DateFormat('dd/MM/yy').format(date))),
                CupertinoButton(child: const Icon(CupertinoIcons.right_chevron), onPressed: () => setState(() => date = date.add(const Duration(days: 1)))),
              ],
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: double.infinity,
                  sections: [
                    PieChartSectionData(color: CupertinoColors.systemRed, radius: 100, value: controller.getNutrition(date).protein),
                    PieChartSectionData(color: CupertinoColors.systemGreen, radius: 100, value: controller.getNutrition(date).fat),
                    PieChartSectionData(color: CupertinoColors.systemYellow, radius: 100, value: controller.getNutrition(date).carbs),
                  ],
                ),
                swapAnimationDuration: const Duration(seconds: 1),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
            Text("You've eaten ${controller.getNutrition(date).kcal} kcals today"),
            CupertinoButton.filled(
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute<void>(builder: (BuildContext context) => addFoodPage(context))),
              child: const Text('Add Food'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            showDayOfWeek: true,
            onDateTimeChanged: (DateTime newDate) => setState(() => date = newDate),
          ),
        ),
      ),
    );
  }

  Widget addFoodPage(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<addTypes>(
          groupValue: _selectedSegment,
          onValueChanged: (addTypes? value) => setState(() => value != null ? _selectedSegment = value : null),
          children: const <addTypes, Widget>{
            addTypes.hundred: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('100')),
            addTypes.total: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Total')),
            addTypes.meal: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Meal')),
          },
        ),
      ),
      child: SizedBox(height: 200, width: 400, child: [_hundred(), _total(), _meal()][_selectedSegment.index]),
    );
  }

  Widget _hundred() {
    return const Center(child: Text('100'));
  }

  Widget _meal() {
    return const Center(child: Text('Meal'));
  }

  Widget _total() {
    return const Center(child: Text('Total'));
  }
}
