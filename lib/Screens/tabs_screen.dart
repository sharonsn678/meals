import 'package:flutter/material.dart';
import 'package:meals/Screens/categories_screen.dart';
import 'package:meals/Screens/meals_screen.dart';
import 'package:meals/Widget/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/Screens/filters_screen.dart';
import 'package:meals/data/dummy_data.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _toogleFavoriteItem(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('remove to favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('add to favorite.');
    }
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,),
      ));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
        final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      onToogleFavoriteMeal: (meal) {
        _toogleFavoriteItem(meal);
      },
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favoriteMeals,
          onTaggleFavoriteItem: (meal) {
            _toogleFavoriteItem(meal);
          });
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier) {
        _setScreen(identifier);
      }),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ]),
    );
  }
}
