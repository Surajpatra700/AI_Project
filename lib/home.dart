import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<File>? imageFile;
  File? _image;
  String result = "";
  ImagePicker? imagePicker;

  // For our app to work we require 3 things :

  // 2. once model is loaded we need a function to pick an image from gallery
  selectPhotoFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  // 1. function to load the tflite model
  loadDataModelFiles() async {
    String? output = await Tflite.loadModel(
      model: "assets/files/model_unquant.tflite",
      labels: "assets/files/labels.txt",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

// 3.and a function to use imageclassification on the slected image
  doImageClassification() async {
    var recognition = await Tflite.runModelOnImage(
      path: _image!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2, // 2 result for image- prediction
    );
    print(recognition!.length.toString());
    setState(() {
      result = "";
    });
    recognition.forEach((element) {
      setState(() {
        print(element.toString());
        result += element['label'] + "\n\n";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/walll.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: 100,),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: selectPhotoFromGallery,
                        onLongPress: capturePhotoFromCamera,
                        child: Container(
                          margin: EdgeInsets.only(top: 30,right: 35,left: 18),
                          child: _image!=null ? Image.file(_image!,height: 360,width: 400, fit: BoxFit.contain,): Container(width: 140,height: 190, child: Icon(Icons.camera_alt_rounded,color: Colors.white,),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 160,),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text("$result",textAlign: TextAlign.center,style: TextStyle(fontSize: 40,color: Colors.pinkAccent,backgroundColor: Colors.white60),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}