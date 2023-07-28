class Day {
  DateTime date;
  List<Nutrition> eaten = [];

  Day({required this.date});

  void addMeal(Meal newMeal) => eaten.add(newMeal);
}

class Meal extends Nutrition {
  String name;
  List<Nutrition> ingridients = [];

  Meal({required this.name});

  void addFood(Nutrition ingridient) => ingridients.add(ingridient);
}

class Nutrition {
  double kcal = 0.0;
  double protein = 0.0;
  double carbs = 0.0;
  double fat = 0.0;

  Nutrition({this.kcal = 0.0, this.protein = 0.0, this.carbs = 0.0, this.fat = 0.0});

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
