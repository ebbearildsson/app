import 'package:app/model.dart';
import 'package:flutter/material.dart';

// Functions we will most likely both use
class Controller {
  Map<DateTime, Day> days = {};
  DateTime today = DateTime.now();

  // ! Temporary values to be replaced with database/local storage
  List<Meal> meals = [
    Meal(name: "Carbonara", description: "delish", icon: const Icon(Icons.fastfood), ingridients: [Nutrition(kcal: 800, protein: 30, fat: 20, carbs: 100)]),
    Meal(name: "Pizza", description: "delish", icon: const Icon(Icons.local_pizza), ingridients: [Nutrition(kcal: 1000, protein: 20, fat: 20, carbs: 100)]),
    Meal(name: "Pasta", description: "delish", icon: const Icon(Icons.fastfood), ingridients: [Nutrition(kcal: 800, protein: 10, fat: 20, carbs: 200)]),
    Meal(name: "Burger", description: "delish", icon: const Icon(Icons.fastfood), ingridients: [Nutrition(kcal: 800, protein: 30, fat: 20, carbs: 10)]),
    Meal(name: "Salad", description: "delish", icon: const Icon(Icons.fastfood), ingridients: [Nutrition(kcal: 400, protein: 5, fat: 20, carbs: 20)]),
  ];

  Nutrition getNutrition(DateTime date) => days.putIfAbsent(date, () => Day(date: date)).nutrients;

  void addNutrients({required String kcal, required String protein, required String fat, required String carbs, required String grams, required DateTime date}) {
    days.putIfAbsent(date, () => Day(date: date)).addFood(Meal(ingridients: [Nutrition.fromStrings(kcal: kcal, protein: protein, fat: fat, carbs: carbs, grams: grams)]));
  }

  void addMeal(Meal meal, DateTime date) {
    days.putIfAbsent(date, () => Day(date: date)).addFood(meal);
  }
}

//  Functions most likely only I will use
class EbbesController extends Controller {}
