import 'package:flutter/material.dart';

class Day {
  DateTime date;
  List<Nutrition> eaten = [];
  Nutrition get nutrition => eaten.fold(Nutrition(), (previousValue, element) => previousValue..add(element));

  Day({required this.date});

  void addFood(Nutrition food) => eaten.add(food);
}

class Meal extends Nutrition {
  String name;
  String description;
  Icon icon;

  Meal({
    required this.name,
    this.description = "",
    this.icon = const Icon(Icons.fastfood),
    required Nutrition nutrition,
  }) : super(
          kcal: nutrition.kcal,
          protein: nutrition.protein,
          carbs: nutrition.carbs,
          fat: nutrition.fat,
        );
}

class Nutrition {
  double kcal;
  double protein;
  double carbs;
  double fat;
  int get roundedKcal => kcal.round();
  int get roundedProtein => protein.round();
  int get roundedCarbs => carbs.round();
  int get roundedFat => fat.round();

  Nutrition({this.kcal = 0.0, this.protein = 1.0, this.carbs = 3.0, this.fat = 2.0});

  add(Nutrition other) {
    kcal += other.kcal;
    protein += other.protein;
    carbs += other.carbs;
    fat += other.fat;
  }

  addBy100(Nutrition nutrition, double grams) {
    kcal = nutrition.kcal * grams / 100;
    protein = nutrition.protein * grams / 100;
    carbs = nutrition.carbs * grams / 100;
    fat = nutrition.fat * grams / 100;
  }
}
