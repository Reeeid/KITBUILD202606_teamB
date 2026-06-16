import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: AlignmentGeometry.center,
      child: Padding(
        padding: EdgeInsetsGeometry.all(30.0),
        child: Column(
          spacing: 16.0,
          children: [
            Flexible(flex: 6, child: Card(child: SizedBox.expand())),
            Flexible(flex: 3, child: Card(child: SizedBox.expand())),
          ],
        ),
      ),
    );
  }
}
