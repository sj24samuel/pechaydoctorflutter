// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    //loadModelStart();
    /*loadModel().then((value) {
      setState(() {});
    });*/
  }


  /*classifyImage(File image) async{
    var output = await Tflite.runModelOnImage(
      path: image.path, 
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output == output;
      _loading = false;
    });
  }

  loadModel() async{
    await Tflite.loadModel(model: 'assets/model_unquant.tflite',labels: 'assets/labels.txt');
    
  }

  loadModelStart() async{
    print("Loading TensorFlow Lite model...");
  try {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
    print("TensorFlow Lite model loaded successfully.");
  } catch (e) {
    print("Error loading TensorFlow Lite model: $e");
    // Handle the error gracefully, e.g., display an error message to the user
  }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }*/
  pickImage() async{
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
     //classifyImage(_image);
  }

  pickGalleryImage() async{
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    // classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(106, 26, 233, 78),
      appBar: AppBar(
        title: const Text("Pechay Doctor"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            Center(child: _loading ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo.png'),
                    const Text("Pechay Disease Detection and Recommender",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 74, 3),
                      fontSize: 18,
                      ) ,
                    ),
                    const SizedBox(height: 50, width: 50)
                  ],
                ) : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    const SizedBox(height: 20,),
                    _output != null ? Text('${_output[0]}', style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                    ): Container(),
                  ],
                )
              ),
              const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 190, 233),
                        borderRadius: BorderRadius.circular(5)
                        ),
                      child: const Text("Scan a Pechay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child:  Container(
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 190, 233),
                        borderRadius: BorderRadius.circular(5)
                        ),
                      child: const Text("Upload a Picture",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      );
  }
}