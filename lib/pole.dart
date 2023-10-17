import 'package:flutter/material.dart';

class Pole extends StatelessWidget {
  const Pole({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.asset('assets/images/pole.png'),
    );
  }
}
