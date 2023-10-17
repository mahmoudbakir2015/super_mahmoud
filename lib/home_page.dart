// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mahmoud/block.dart';
import 'package:super_mahmoud/cloud.dart';
import 'package:super_mahmoud/dollar.dart';
import 'package:super_mahmoud/game_over.dart';
import 'package:super_mahmoud/jumping_mario.dart';
import 'package:super_mahmoud/mushroom.dart';
import 'package:super_mahmoud/pole.dart';
import 'mario.dart';
import 'buttons.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const maxTime = 999;
  int sec = maxTime;
  Timer? t;

  bool hasGameStarted = false;
  static double marioSize = 50;
  static double marioX = -0.935;
  static double marioY = 0.4;
  static double poleX = -1.2;
  static double poleY = 1;
  double height = 0;
  double time = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool run = false;
  // ignore: non_constant_identifier_names
  bool jump_air = false;
  static double mushX = 0.2;
  static double mushY = 1;
  double mushX1 = mushX + 1.5;

  static double blockX1 = -0.4;
  static double blockX2 = blockX1 + 0.6;
  static double blockX3 = blockX1 + 1.4;
  static double blockY = 0.15;

  static double dollarX1 = blockX1;
  double dollarX2 = blockX2;
  double dollarX3 = blockX3;
  double dollarY1 = blockY;
  double dollarY2 = blockY;
  double dollarY3 = blockY;
  int money = 0;

  static double cloudX1 = -1;
  double cloudX2 = cloudX1 + 1;
  double cloudX3 = cloudX1 + 2;

  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(fontSize: 22, color: Colors.white));

  void playSound(String s) async {
    final player = AudioPlayer();
    await player.play(AssetSource(s));
  }

  void resetTimer() {
    setState(() {
      sec = maxTime;
      marioX = -0.935;
      marioY = 0.4;
      poleX = -1.2;
      poleY = 1;
    });
  }

  int startTimer() {
    if (hasGameStarted) {
      t = Timer.periodic(Duration(seconds: 1), (timer) {
        if (sec > 0 && mounted) {
          setState(() {
            sec--;
          });
          timer.cancel();
        } else {
          hasGameStarted = false;
          resetTimer();
          playSound("audios/mario_end_sound.mp3");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => GameOverPage(
                        score: money,
                      )));
        }
        timer.cancel();
      });
    }
    return sec;
  }

  // ignore: non_constant_identifier_names
  void CheckifAteMushrooom() {
    if ((marioX - mushX).abs() < 0.05 && (marioY - mushY).abs() < 0.05) {
      money += 50;
      setState(() {
        marioSize = 100;
        playSound("assets/audios/mushroom_sound.mp3");
        mushX = 2;
        Future.delayed(const Duration(seconds: 3), () {
          marioSize = 50;
        });
      });
    }
    if ((marioX - mushX1).abs() < 0.05 && (marioY - mushY).abs() < 0.05) {
      money += 50;
      setState(() {
        marioSize = 100;
        playSound("assets/audios/mushroom_sound.mp3");
        mushX1 = 4.5;
        Future.delayed(const Duration(seconds: 3), () {
          marioSize = 50;
        });
      });
    }
  }

  void releaseDollar1() {
    money += 10;
    playSound("assets/audios/coin_sound.mp3");
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        dollarY1 -= 0.1;
      });
      if (dollarY1 < -1) {
        timer.cancel();
        dollarY1 = blockY;
      }
    });
  }

  void releaseDollar2() {
    money += 10;
    playSound("assets/audios/coin_sound.mp3");
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        dollarY2 -= 0.1;
      });
      if (dollarY2 < -1) {
        timer.cancel();
        dollarY2 = blockY;
      }
    });
  }

  void releaseDollar3() {
    money += 10;
    playSound("assets/audios/coin_sound.mp3");
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        dollarY3 -= 0.1;
      });
      if (dollarY3 < -1) {
        timer.cancel();
        dollarY3 = blockY;
      }
    });
  }

  bool onPlatform(double x, double y) {
    if ((x - blockX1).abs() < 0.08 && (y - blockY).abs() < 0.08) {
      jump_air = false;
      marioY = blockY - 0.28;
      return true;
    } else {
      return false;
    }
  }

  void fall() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        marioY += 0.05;
      });
      if (marioY > 1) {
        marioY = 1;
        timer.cancel();
        jump_air = false;
      }
    });
  }

  void prejump() {
    hasGameStarted = true;
    initialHeight = marioY;
    time = 0;
  }

  void jump() {
    hasGameStarted = true;
    if (jump_air == false) {
      prejump();

      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          setState(() {
            jump_air = false;
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
        if ((marioX - blockX1).abs() < 0.03) {
          setState(() {
            marioY = blockY + 0.56 - height;
          });
          releaseDollar1();
          fall();
          timer.cancel();
        }
        if ((marioX - blockX2).abs() < 0.03) {
          setState(() {
            marioY = blockY + 0.56 - height;
          });
          releaseDollar2();
          fall();
          timer.cancel();
        }
        if ((marioX - blockX3).abs() < 0.03) {
          setState(() {
            marioY = blockY + 0.56 - height;
          });
          releaseDollar3();
          fall();
          timer.cancel();
        }
      });
    }
  }

  void moveRight() {
    hasGameStarted = true;
    direction = "right";
    CheckifAteMushrooom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      CheckifAteMushrooom();
      if (Button().isholdingButton() == true) {
        setState(() {
          marioX += 0.02;
          run = !run;
          if (marioY < 1) {
            marioX += 0.04;
            fall();
          }
        });
        setState(() {
          if (mushX < -1.5) {
            mushX += 2.5;
          } else {
            mushX -= 0.01;
          }
        });
        setState(() {
          if (mushX1 < -1.5) {
            mushX1 += 3.5;
          } else {
            mushX1 -= 0.01;
          }
        });
        setState(() {
          if (poleX < -1.5) {
            poleX = -1.5;
          } else {
            poleX -= 0.02;
          }
        });
        setState(() {
          if (cloudX1 < -1.5) {
            cloudX1 += 3;
          } else {
            cloudX1 -= 0.02;
          }
        });
        setState(() {
          if (cloudX2 < -1.5) {
            cloudX2 += 3.25;
          } else {
            cloudX2 -= 0.02;
          }
        });
        setState(() {
          if (cloudX3 < -1.5) {
            cloudX3 += 3.5;
          } else {
            cloudX3 -= 0.02;
          }
        });
        setState(() {
          if (blockX1 < -1.5) {
            blockX1 += 3.5;
          } else {
            blockX1 -= 0.02;
          }
        });
        setState(() {
          if (blockX2 < -1.5) {
            blockX2 += 4.5;
          } else {
            blockX2 -= 0.02;
          }
        });
        setState(() {
          if (blockX3 < -1.5) {
            blockX3 += 5.5;
          } else {
            blockX3 -= 0.02;
          }
        });
        setState(() {
          if (dollarX1 < -1.5) {
            dollarX1 += 3.5;
          } else {
            dollarX1 -= 0.02;
          }
        });
        setState(() {
          if (dollarX2 < -1.5) {
            dollarX2 += 4.5;
          } else {
            dollarX2 -= 0.02;
          }
        });
        setState(() {
          if (dollarX3 < -1.5) {
            dollarX3 += 5.5;
          } else {
            dollarX3 -= 0.02;
          }
        });

        if (marioX > 1) {
          setState(() {
            marioX = -1;
            poleX = -1.5;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    hasGameStarted = true;
    direction = "left";
    CheckifAteMushrooom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      CheckifAteMushrooom();
      if (Button().isholdingButton() == true && marioX > -1) {
        setState(() {
          marioX -= 0.02;
          run = !run;
          if (marioY < 1) {
            marioX -= 0.04;
            fall();
          }
        });
        setState(() {
          if (mushX < 1.5) {
            mushX += 0.02;
          }
        });
        setState(() {
          if (mushX1 < 1.5) {
            mushX1 += 0.02;
          }
        });
        setState(() {
          if (cloudX1 > 1.5) {
            cloudX1 -= 3.25;
          } else {
            cloudX1 += 0.02;
          }
        });
        setState(() {
          if (cloudX2 > 1.5) {
            cloudX2 -= 3.5;
          } else {
            cloudX2 += 0.02;
          }
        });
        setState(() {
          if (cloudX3 > 1.5) {
            cloudX3 -= 4;
          } else {
            cloudX3 += 0.02;
          }
        });
        setState(() {
          if (blockX1 > 1.5) {
            blockX1 -= 3.5;
          } else {
            blockX1 += 0.02;
          }
        });
        setState(() {
          if (blockX2 > 1.5) {
            blockX2 -= 4.5;
          } else {
            blockX2 += 0.02;
          }
        });
        setState(() {
          if (blockX3 > 1.5) {
            blockX3 -= 5.5;
          } else {
            blockX3 += 0.02;
          }
        });
        setState(() {
          if (dollarX1 > 1.5) {
            dollarX1 -= 3.5;
          } else {
            dollarX1 += 0.02;
          }
        });
        setState(() {
          if (dollarX2 > 1.5) {
            dollarX2 -= 4.5;
          } else {
            dollarX2 += 0.02;
          }
        });
        setState(() {
          if (dollarX3 > 1.5) {
            dollarX3 -= 5.5;
          } else {
            dollarX3 += 0.02;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(marioX, marioY),
                        child: jump_air
                            ? JumpingMario(
                                direction: direction,
                                size: marioSize,
                              )
                            : MyMario(
                                direction: direction,
                                run: run,
                                size: marioSize,
                              )),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(poleX, poleY),
                    child: Pole(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(mushX, mushY),
                    child: Mushroom(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(mushX1, mushY),
                    child: Mushroom(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(cloudX1, -0.90),
                    child: Cloud(
                      size: 170.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(cloudX2, -0.95),
                    child: Cloud(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(cloudX3, -0.95),
                    child: Cloud(
                      size: 190.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(dollarX1, dollarY1),
                    child: Dollar(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(dollarX2, dollarY2 - 0.3),
                    child: Dollar(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(dollarX3, dollarY3 - 0.1),
                    child: Dollar(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(blockX1, blockY),
                    child: Block(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(blockX2, blockY - 0.3),
                    child: Block(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(blockX3, blockY - 0.1),
                    child: Block(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Mario",
                              style: gameFont,
                            ),
                            Text(
                              money.toString(),
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "World",
                              style: gameFont,
                            ),
                            Text(
                              "1-1",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Time",
                              style: gameFont,
                            ),
                            Text(
                              startTimer().toString(),
                              style: gameFont,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ])),
            Container(
              height: 12,
              color: Colors.green,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      function: moveLeft,
                    ),
                    Button(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                      function: jump,
                    ),
                    Button(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      function: moveRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
