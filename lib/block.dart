import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: Image.asset('assets/images/block.png'),
    );
  }
}
