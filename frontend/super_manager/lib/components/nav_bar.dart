

import 'package:flutter/material.dart';

class NavRail extends StatelessWidget{
  const NavRail({super.key, required this.index, required this.onDestinationSelected});
  final int index;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context){
    return NavigationRail(
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary
      ),
      selectedLabelTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary
      ),
      labelType: NavigationRailLabelType.all,
      backgroundColor: Theme.of(context).colorScheme.primary,
      destinations: [
      NavigationRailDestination(icon: Icon(Icons.shopping_bag), label: Text('買い物')),
      NavigationRailDestination(icon: Icon(Icons.store), label: Text('店舗')),
      NavigationRailDestination(icon: Icon(Icons.inventory), label: Text('商品')),
    ], selectedIndex: index,
    onDestinationSelected: onDestinationSelected,
    );
  }
}