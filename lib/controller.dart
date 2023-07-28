// A controller with functions for accessing data

import 'package:app/model.dart';

// Functions we will most likely both use
class Controller {
  List<Day> days = [];
  DateTime today = DateTime.now();

  // TODO: should probably just use a dictionary for days
  Nutrition getNutrition(DateTime date) {
    return days.firstWhere(
      (element) => element.date == date,
      orElse: () {
        days.add(Day(date: date));
        return days.last;
      },
    ).nutrition;
  }

  // TODO: should probably just use a dictionary for days
  addFood(Nutrition food, String name, DateTime date) {
    days.firstWhere(
      (element) => element.date == date,
      orElse: () {
        days.add(Day(date: date));
        return days.last;
      },
    ).addMeal(Meal(name: name, nutrition: food));
  }
}

//  Functions most likely only I will use
class EbbesController extends Controller {}
