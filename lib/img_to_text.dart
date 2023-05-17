import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageToText extends StatefulWidget {
  const ImageToText({super.key});

  @override
  State<ImageToText> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  String result = "";
  File? image;
  ImagePicker? imagePicker;

  pickImageFromGallery() async {
    final pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      return;
    }
    setState(() {
      
    });
  }

  pickImageFromCamera() async {
    final pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      return;
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
