import 'package:meals/providers/filter_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredMealsProvider = Provider((ref){
  final activefilters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);

  return meals.where((element) {
    if (activefilters[Filter.glutenFree]! && !element.isGlutenFree) {
      return false;
    }
    if (activefilters[Filter.lactoseFree]! && !element.isLactoseFree){
      return false;
    }
    if (activefilters[Filter.vegetarian]! && !element.isVegetarian){
      return false;
    }
    if (activefilters[Filter.vegan]! && !element.isVegan){
      return false;
    }
    return true;
  }).toList();

});

  