

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen(
      {required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteMealsProvider);
    final isFavorite = favorites.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
               final wasAdded = ref.read(favoriteMealsProvider.notifier).toogleFavoriteStatus(meal);
               ScaffoldMessenger.of(context).clearSnackBars();
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: 
                    Text(
                      wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),)
               );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(microseconds: 300),
                transitionBuilder: (child, animation) => RotationTransition(turns:Tween(begin: 0.5, end: 1.0).animate(animation), child: child,),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined, key: ValueKey(isFavorite), ),
              ),
                color: Colors.white,
              ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final step in meal.steps)
              Text(
                step,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
          ],
        ),
      ),
    );
  }
}
