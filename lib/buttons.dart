import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final child;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  static bool holdingbutton = false;
  const Button({super.key, this.child, this.function});

  bool isholdingButton() {
    return holdingbutton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingbutton = true;
        function();
      },
      onTapUp: (details) {
        holdingbutton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
