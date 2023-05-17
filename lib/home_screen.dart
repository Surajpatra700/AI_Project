import 'package:ai_project/fruit_detection.dart';
import 'package:ai_project/home.dart';
import 'package:ai_project/object_detection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ai Detection"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(Home());
                },
                child: Text("Marvel Hero Detection")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {
              Get.to(FruitDetection());
            }, child: Text("Fruits Detection")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {
              Get.to(ObjectDetection());
            }, child: Text("Object Detection")),
          ],
        ),
      ),
    );
  }
}
