import 'package:flutter/material.dart';
import 'package:meals/Screens/meal_detail_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/Widget/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.meals,
      this.title,
      required this.onTaggleFavoriteItem});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal) onTaggleFavoriteItem;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          onToggleFavorite: (meal) {
            onTaggleFavoriteItem(meal);
          },
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meals[index]);
          }),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try select a different catetory',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title ?? ""),
        ),
        body: content);
  }
}
