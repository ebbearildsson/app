// A controller with functions for accessing data

import 'package:app/model.dart';
import 'package:flutter/material.dart';

// Functions we will most likely both use
class Controller {
  List<Day> days = [];

  // ! Tmeperary values to be replaced with database
  List<Meal> meals = [
    Meal(name: "Carbonara", description: "delish", icon: const Icon(Icons.fastfood), nutrition: Nutrition(kcal: 800, protein: 30, fat: 20, carbs: 100)),
    Meal(name: "Pizza", description: "delish", icon: const Icon(Icons.local_pizza), nutrition: Nutrition(kcal: 1000, protein: 20, fat: 20, carbs: 100)),
    Meal(name: "Pasta", description: "delish", icon: const Icon(Icons.fastfood), nutrition: Nutrition(kcal: 800, protein: 10, fat: 20, carbs: 200)),
    Meal(name: "Burger", description: "delish", icon: const Icon(Icons.fastfood), nutrition: Nutrition(kcal: 800, protein: 30, fat: 20, carbs: 10)),
    Meal(name: "Salad", description: "delish", icon: const Icon(Icons.fastfood), nutrition: Nutrition(kcal: 400, protein: 5, fat: 20, carbs: 20)),
  ];
  DateTime today = DateTime.now();

  // ? should probably just use a dictionary for days
  Nutrition getNutrition(DateTime date) {
    return days.firstWhere(
      (element) => element.date == date,
      orElse: () {
        days.add(Day(date: date));
        return days.last;
      },
    ).nutrition;
  }

  // ? should probably just use a dictionary for days
  addFood({Meal? meal, double? kcal, double? protein, double? fat, double? carbs, required DateTime date}) {
    days.firstWhere(
      (element) => element.date == date,
      orElse: () {
        days.add(Day(date: date));
        return days.last;
      },
    ).addFood(meal ?? Nutrition(kcal: kcal ?? 0, protein: protein ?? 0, fat: fat ?? 0, carbs: carbs ?? 0));
  }
}

//  Functions most likely only I will use
class EbbesController extends Controller {}
