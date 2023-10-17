import 'package:flutter/material.dart';

class Dollar extends StatelessWidget {
  const Dollar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: Image.asset('assets/images/dollar.png'),
    );
  }
}
