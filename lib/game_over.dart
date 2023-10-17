import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mahmoud/home_page.dart';

import 'package:delayed_display/delayed_display.dart';

// ignore: must_be_immutable
class GameOverPage extends StatelessWidget {
  int score = 0;
  GameOverPage({super.key, required this.score});

  var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(fontSize: 22, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                ("assets/images/gameOver.gif"),
              ),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 45,
                ),
                DelayedDisplay(
                  delay: const Duration(seconds: 2),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 205),
                    child: Row(
                      children: [
                        Text("Your Score is :", style: gameFont),
                        const SizedBox(height: 20),
                        Text(score.toString(), style: gameFont),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 280),
                DelayedDisplay(
                  delay: const Duration(seconds: 3),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 500),
                    child: Row(children: [
                      TextButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Homepage()));
                          }),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text('Try Again', style: gameFont)),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
