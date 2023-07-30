import 'package:flutter/material.dart';

class Day {
  DateTime date;
  List<Meal> eaten = [];
  Nutrition get nutrients => eaten.fold(Nutrition(), (previousValue, element) => previousValue + element.nutrients);

  Day({required this.date});

  void addFood(Meal food) => eaten.add(food);
}

class Meal {
  final Icon icon;
  final String name;
  final String description;
  final List<Nutrition> ingridients = [];

  Nutrition get nutrients => ingridients.fold(Nutrition(), (previousValue, element) => previousValue + element);
  int get protein => ingridients.fold(0.0, (previousValue, element) => previousValue + element.protein).round();
  int get carbs => ingridients.fold(0.0, (previousValue, element) => previousValue + element.carbs).round();
  int get kcal => ingridients.fold(0.0, (previousValue, element) => previousValue + element.kcal).round();
  int get fat => ingridients.fold(0.0, (previousValue, element) => previousValue + element.fat).round();

  Meal({this.name = "No name given", this.description = "", this.icon = const Icon(Icons.fastfood), List<Nutrition> ingridients = const []}) {
    this.ingridients.addAll(ingridients);
  }
}

class Nutrition {
  final double protein;
  final double carbs;
  final double kcal;
  final double fat;

  Nutrition({this.kcal = 0.0, this.protein = 0.0, this.carbs = 0.0, this.fat = 0.0});

  Nutrition operator +(Nutrition other) => Nutrition(kcal: kcal + other.kcal, protein: protein + other.protein, carbs: carbs + other.carbs, fat: fat + other.fat);

  factory Nutrition.fromStrings({required String kcal, required String protein, required String fat, required String carbs, String grams = "100"}) {
    double factor = (double.tryParse(grams) ?? 100.0) / 100.0;
    return Nutrition(
      protein: (double.tryParse(protein) ?? 0.0) * factor,
      carbs: (double.tryParse(carbs) ?? 0.0) * factor,
      kcal: (double.tryParse(kcal) ?? 0.0) * factor,
      fat: (double.tryParse(fat) ?? 0.0) * factor,
    );
  }
}
