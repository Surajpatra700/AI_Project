import 'package:ai_project/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      title: Text("Cat & Dog Classifier",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 25, color: Colors.blue),),
      image: Image.network("https://w7.pngwing.com/pngs/625/104/png-transparent-cats-and-dogs-love-each-other-golden-kitty-kiss.png"),
      backgroundColor: Colors.black87,
      photoSize: 60,
      loaderColor: Colors.blue.shade900,
    );
  }
}