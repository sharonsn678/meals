import 'package:flutter/material.dart';
import 'package:meals/Widget/category_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/Screens/meals_screen.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToogleFavoriteMeal, required this.availableMeals});
  final void Function(Meal) onToogleFavoriteMeal;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category category) {
    // final selectedMeals = dummyMeals
    // .where((element) => element.categories.contains(category.id)).toList();

    final filteredMeals = availableMeals
    .where((meal) => meal.categories.contains(category.id))
    .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals, onTaggleFavoriteItem: (meal){
          onToogleFavoriteMeal(meal);
        },),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category, onSelectedCategory: (){
              _selectedCategory(context, category);
            } )
        ],
    );
  }
}
