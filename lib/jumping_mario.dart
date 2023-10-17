import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final direction;
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const JumpingMario({super.key, this.direction, this.size});
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return SizedBox(
        height: size,
        width: size,
        child: Image.asset('assets/images/jumping_mario.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          height: size,
          width: size,
          child: Image.asset('assets/images/jumping_mario.png'),
        ),
      );
    }
  }
}
