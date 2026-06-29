import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
    required this.onSelected,
  });
  final int index;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      onTap: onSelected,
      currentIndex: index,
      backgroundColor: Theme.of(context).colorScheme.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '買い物'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: '店舗'),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: '商品'),
      ],
    );
  }
}
