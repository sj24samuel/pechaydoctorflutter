import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final bool _loading = true;
  late File _image;
  //late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    //loadModel();
  }


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
       backgroundColor:  const Color.fromARGB(255, 85, 206, 4),
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
                      color: Colors.white,
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
                    /*_output != null ? Text('${_output[0]}', 
                      style:  const TextStyle(
                      color: Colors.white,
                     fontSize: 20,),
                    )*/
                  ],
            ),
          ),
              const SizedBox(height: 15),
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
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                  GestureDetector(
                    child:  Container(
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 52, 4, 224),
                        borderRadius: BorderRadius.circular(5)
                        ),
                      child: const Text("Predict",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
            ]

        ),
      ),
    );
  }
}