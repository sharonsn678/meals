import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Screens/categories_screen.dart';
import 'package:meals/Screens/meals_screen.dart';
import 'package:meals/Widget/main_drawer.dart';
import 'package:meals/Screens/filters_screen.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filter_meal_provider.dart';
import 'package:meals/providers/filter_provider.dart';
import 'package:meals/providers/meals_provider.dart';

//const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false
// };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const FiltersScreen(),
      ));
  
    } else {
      Navigator.pop(context);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      onToogleFavoriteMeal: (meal) {
      },
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
          meals: favoriteMeals,
          );
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
