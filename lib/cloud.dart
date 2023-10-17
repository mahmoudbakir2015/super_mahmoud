import 'package:flutter/material.dart';

class Cloud extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const Cloud({super.key, this.size});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset('assets/images/cloud.png'),
    );
  }
}
