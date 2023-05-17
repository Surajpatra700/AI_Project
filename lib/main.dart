import 'package:ai_project/fruit_detection.dart';
import 'package:ai_project/home_screen.dart';
import 'package:ai_project/object_detection.dart';
import 'package:ai_project/splashScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // avaialbleCameras checks whether your device has camera or not.. usually there are 2 cameras.. 1st the rear & 2nd the front camera
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homescreen(),
    );
  }
}