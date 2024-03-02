import 'package:flutter/material.dart';
import 'package:meals/Widget/category_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/Screens/meals_screen.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.onToogleFavoriteMeal, required this.availableMeals});
  final void Function(Meal) onToogleFavoriteMeal;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationContorller;

  @override
  void initState(){
    super.initState();
    _animationContorller = AnimationController(vsync: this,
    duration:  const Duration(microseconds: 300),
    lowerBound: 0,
    upperBound: 1,
    );
    _animationContorller.forward();
  }

  @override
  void dispose(){
    _animationContorller.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    // final selectedMeals = dummyMeals
    // .where((element) => element.categories.contains(category.id)).toList();

    final filteredMeals = widget.availableMeals
    .where((meal) => meal.categories.contains(category.id))
    .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationContorller,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.0, 0.3),
          end: const Offset(0.0, 0.0))
          .animate(CurvedAnimation(parent: _animationContorller, curve: Curves.easeInOut)),
      child:child),
    );
  }
}
