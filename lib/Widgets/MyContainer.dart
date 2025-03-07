import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;

  MyContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          color: Colors.white),
      child: child,
    );
  }
}
