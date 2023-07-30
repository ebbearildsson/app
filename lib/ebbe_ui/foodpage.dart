import 'package:app/controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

EbbesController controller = EbbesController();
DateTime activeDate = controller.today;

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
                  centerSpaceRadius: double.infinity,
                  sections: [
                    PieChartSectionData(
                        color: CupertinoColors.systemYellow,
                        radius: 100,
                        value: controller.getNutrition(activeDate).carbs,
                        title: '${controller.getNutrition(activeDate).carbs.round()} g',
                        titleStyle: CupertinoTheme.of(context).textTheme.textStyle),
                    PieChartSectionData(
                        color: CupertinoColors.systemRed,
                        radius: 100,
                        value: controller.getNutrition(activeDate).protein,
                        title: '${controller.getNutrition(activeDate).protein.round()} g',
                        titleStyle: CupertinoTheme.of(context).textTheme.textStyle),
                    PieChartSectionData(
                        color: CupertinoColors.systemGreen,
                        radius: 100,
                        value: controller.getNutrition(activeDate).fat,
                        title: '${controller.getNutrition(activeDate).fat.round()} g',
                        titleStyle: CupertinoTheme.of(context).textTheme.textStyle),
                  ],
                ),
                swapAnimationDuration: const Duration(seconds: 1),
                swapAnimationCurve: Curves.linear,
              ),
            ),
            Text("You've eaten ${controller.getNutrition(activeDate).kcal} kcals today"),
            CupertinoButton.filled(
              onPressed: () => _navigateAndDisplaySelection(context),
              child: const Text('Add Food'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final List<String> result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddFoodPage()));
    setState(() => controller.addNutrients(kcal: result[0], protein: result[1], fat: result[2], carbs: result[3], grams: result.length == 5 ? result[4] : "100", date: activeDate));
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
            onDateTimeChanged: (DateTime selected) => setState(() => activeDate = selected),
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

  Widget _meal(BuildContext context) {
    return ListView.builder(
      itemCount: controller.meals.length,
      itemBuilder: (context, index) => CupertinoButton(
        child: CupertinoListTile(
          title: Text(controller.meals[index].name),
          subtitle: Text(controller.meals[index].description),
          leading: controller.meals[index].icon,
          trailing: Text('${controller.meals[index].kcal} KCALs'),
        ),
        onPressed: () => Navigator.pop(context, [
          controller.meals[index].kcal.toString(),
          controller.meals[index].protein.toString(),
          controller.meals[index].fat.toString(),
          controller.meals[index].carbs.toString(),
        ]),
      ),
    );
  }

  Widget _total() {
    List<TextEditingController> controllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          input(controllers[0], "Calories"),
          input(controllers[1], "Protein"),
          input(controllers[2], "Fat"),
          input(controllers[3], "Carbs"),
          CupertinoButton.filled(
            onPressed: () => Navigator.pop(
              context,
              [
                controllers[0].text,
                controllers[1].text,
                controllers[2].text,
                controllers[3].text,
              ],
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _hundred() {
    List<TextEditingController> controllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          input(controllers[0], "Calories"),
          input(controllers[1], "Protein"),
          input(controllers[2], "Fat"),
          input(controllers[3], "Carbs"),
          input(controllers[4], "Grams"),
          CupertinoButton.filled(
            onPressed: () => Navigator.pop(
              context,
              [
                controllers[0].text,
                controllers[1].text,
                controllers[2].text,
                controllers[3].text,
                controllers[4].text,
              ],
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget input(TextEditingController controller, String placeholder) =>
      Container(margin: const EdgeInsets.all(20), child: CupertinoTextField(controller: controller, placeholder: placeholder, keyboardType: TextInputType.number));
}
