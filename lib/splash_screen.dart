import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:super_mahmoud/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void playSound(String s) async {
    final player = AudioPlayer();
    await player.play(
      AssetSource(s),
    );
  }

  @override
  void initState() {
    super.initState();
    playSound("assets/audios/mario_song.mp3");
    nextPage();
  }

  nextPage() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset(
            'assets/images/mario_image.png',
            height: 400,
            width: 400,
          ),
        ),
      ),
    );
  }
}
