import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/Screens/tabs_screen.dart';

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(172, 23, 180, 1),
        brightness: Brightness.dark),
    textTheme: GoogleFonts.latoTextTheme());

void main() {
  runApp(
    const ProviderScope(child: MealsApp()),
  );
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
      //home: MealsScreen(meals: dummyMeals, title: "title")
    );
  }
}
