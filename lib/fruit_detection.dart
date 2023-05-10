import 'package:ai_project/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class FruitDetection extends StatefulWidget {
  const FruitDetection({super.key});

  @override
  State<FruitDetection> createState() => _FruitDetectionState();
}

class _FruitDetectionState extends State<FruitDetection> {
  bool isWorking = false;
  String result = "";
  CameraController? cameraController;
  CameraImage? imgCamera;

  initCamera() {
    // created a camera controller
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    // initialized the controller
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        // Started image streaming
        cameraController!.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = imageFromStream;
            runModelOnStreamFrames();
          }
        });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/files2/model_unquant.tflite",
      labels: "assets/files2/labels.txt",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await Tflite.close();
    cameraController!.dispose();
  }

  runModelOnStreamFrames() async {
    // recognize the image/video that is displayed in front of frame
    var recognition = await Tflite.runModelOnFrame(
      // image is a file & it can be converted into bytes
      // Converts image into bytes and stores it in a list/array
      bytesList: imgCamera!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: imgCamera!.height,
      imageWidth: imgCamera!.width,
      numResults: 2,
    );
    result = "";
    recognition!.forEach((response) {
      // "toStringAsFixed" means string representation of the number upto 2 decimal places
      result += response["label"] +
          " " +
          (response["confidence"] as double).toStringAsFixed(2) +
          "\n\n";
    });
    setState(() {
      result;
    });
    isWorking = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Fruit_Detection"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgg.jpg"),fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      height: 220,
                      width: 320,
                      child: Image.asset("assets/images/window.jpg"),
                    ),
                  ),

                  Center(
                    child: TextButton(onPressed: (){
                      initCamera();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 65),
                      height: 270,
                      width: 360,
                      child: imgCamera == null 
                      ? 
                      Container(height: 270,width: 360,child: Icon(Icons.photo_camera,color: Colors.deepPurple,size: 60,),) 
                      :
                      AspectRatio(aspectRatio: cameraController!.value.aspectRatio, child: CameraPreview(cameraController!),),
                    )),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 55),
                  child: SingleChildScrollView(
                    child: Text(
                      result, style: TextStyle(
                        backgroundColor: Colors.black87,fontSize: 25,color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}