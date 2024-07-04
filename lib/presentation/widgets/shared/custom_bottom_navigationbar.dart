import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Minimo 2 y ademas tienen que tener un label
    return BottomNavigationBar(elevation: 0, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.label_outline), label: 'Category'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline), label: 'Favorites'),
    ]);
  }
}
