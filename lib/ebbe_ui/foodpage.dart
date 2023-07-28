import 'package:app/controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

enum AddTypes { hundred, total, meal }

EbbesController controller = EbbesController();
DateTime activeDate = controller.today;

class _FoodPageState extends State<FoodPage> {
  int? touchedIndex;

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
                CupertinoButton(child: const Icon(CupertinoIcons.left_chevron), onPressed: () => setState(() => activeDate = activeDate.subtract(const Duration(days: 1)))),
                CupertinoButton(onPressed: () => _showDatePicker(context), child: Text(DateFormat('dd/MM/yy').format(activeDate))),
                CupertinoButton(child: const Icon(CupertinoIcons.right_chevron), onPressed: () => setState(() => activeDate = activeDate.add(const Duration(days: 1)))),
              ],
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    enabled: true,
                    touchCallback: (FlTouchEvent event, pieTouchResponse) => setState(() => touchedIndex = pieTouchResponse?.touchedSection?.touchedSectionIndex),
                  ),
                  centerSpaceRadius: double.infinity,
                  sections: [
                    PieChartSectionData(color: CupertinoColors.systemRed, radius: touchedIndex == 0 ? 120 : 100, value: controller.getNutrition(activeDate).protein),
                    PieChartSectionData(color: CupertinoColors.systemGreen, radius: touchedIndex == 1 ? 120 : 100, value: controller.getNutrition(activeDate).fat),
                    PieChartSectionData(color: CupertinoColors.systemYellow, radius: touchedIndex == 2 ? 120 : 100, value: controller.getNutrition(activeDate).carbs),
                  ],
                ),
                swapAnimationDuration: const Duration(seconds: 1),
                swapAnimationCurve: Curves.easeInCubic,
              ),
            ),
            Text("You've eaten ${controller.getNutrition(activeDate).roundedKcal} kcals today"),
            CupertinoButton.filled(
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute<void>(builder: (BuildContext context) => AddFoodPage())),
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
            initialDateTime: activeDate,
            mode: CupertinoDatePickerMode.date,
            showDayOfWeek: true,
            onDateTimeChanged: (DateTime newDate) => setState(() => activeDate = newDate),
          ),
        ),
      ),
    );
  }
}

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  int? _index = 1;
  final Map<int, Widget> children = const <int, Widget>{
    0: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('100')),
    1: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Total')),
    2: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Meal')),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: CupertinoSlidingSegmentedControl<int>(groupValue: _index, onValueChanged: (int? value) => setState(() => _index = value), children: children)),
      child: [_hundred(), _total(), _meal(context)][_index ?? 0],
    );
  }

  Widget _hundred() {
    return const Center(child: Text('100'));
  }

  Widget _meal(BuildContext context) {
    return ListView.builder(
      itemCount: controller.meals.length,
      itemBuilder: (context, index) => CupertinoButton(
        child: CupertinoListTile(
          title: Text(controller.meals[index].name),
          subtitle: Text(controller.meals[index].description),
          leading: controller.meals[index].icon,
          trailing: Text('${controller.meals[index].roundedKcal} KCALs'),
        ),
        onPressed: () => setState(() => controller.addFood(meal: controller.meals[index], date: activeDate)),
      ),
    );
  }

  Widget _total() {
    List<TextEditingController> controllers = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoTextField(controller: controllers[0], placeholder: 'Calories', keyboardType: TextInputType.number),
          CupertinoTextField(controller: controllers[1], placeholder: 'Protein', keyboardType: TextInputType.number),
          CupertinoTextField(controller: controllers[2], placeholder: 'Fat', keyboardType: TextInputType.number),
          CupertinoTextField(controller: controllers[3], placeholder: 'Carbs', keyboardType: TextInputType.number),
          CupertinoButton.filled(
            onPressed: () => setState(() => controller.addFood(
                kcal: double.parse(controllers[0].text != "" ? controllers[0].text : "0"),
                protein: double.parse(controllers[1].text != "" ? controllers[1].text : "0"),
                fat: double.parse(controllers[2].text != "" ? controllers[2].text : "0"),
                carbs: double.parse(controllers[3].text != "" ? controllers[3].text : "0"),
                date: activeDate)),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
