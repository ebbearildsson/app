class Day {
  DateTime date;
  List<Nutrition> eaten = [];
  Nutrition get nutrition => eaten.fold(Nutrition(), (previousValue, element) => previousValue..add(element));

  Day({required this.date});

  void addMeal(Meal newMeal) => eaten.add(newMeal);
}

class Meal extends Nutrition {
  String name;

  Meal({required this.name, required Nutrition nutrition}) : super(kcal: nutrition.kcal, protein: nutrition.protein, carbs: nutrition.carbs, fat: nutrition.fat);
}

class Nutrition {
  double kcal;
  double protein;
  double carbs;
  double fat;
  double get total => protein + carbs + fat;

  Nutrition({this.kcal = 0.0, this.protein = 1.0, this.carbs = 3.0, this.fat = 2.0});

  add(Nutrition other) {
    kcal += other.kcal;
    protein += other.protein;
    carbs += other.carbs;
    fat += other.fat;
  }

  void addBy100(Nutrition nutrition, double grams) {
    kcal = nutrition.kcal * grams / 100;
    protein = nutrition.protein * grams / 100;
    carbs = nutrition.carbs * grams / 100;
    fat = nutrition.fat * grams / 100;
  }
}
