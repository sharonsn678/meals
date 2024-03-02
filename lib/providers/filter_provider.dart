import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterProvider extends StateNotifier<Map<Filter, bool>>{
  FilterProvider() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  });

  void setFilters(Map<Filter, bool> choosenFilters){
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive){
    state = {...state, filter: isActive};
  }

}

final filtersProvider = StateNotifierProvider<FilterProvider, Map<Filter,bool>>((ref) => FilterProvider());