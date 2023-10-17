import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final direction;
  // ignore: prefer_typing_uninitialized_variables
  final run;
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const MyMario({super.key, this.direction, this.run, this.size});
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return SizedBox(
        height: size,
        width: size,
        child: run
            ? Image.asset(
                'assets/images/position_mario.png',
              )
            : Image.asset(
                'assets/images/running_mario.png',
              ),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          height: size,
          width: size,
          child: run
              ? Image.asset(
                  'assets/images/position_mario.png',
                )
              : Image.asset(
                  'assets/images/running_mario.png',
                ),
        ),
      );
    }
  }
}
