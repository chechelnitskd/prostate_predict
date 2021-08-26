import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prostate_predict/functions/loading.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class SkinCancerScreen extends StatefulWidget {
  const SkinCancerScreen({Key? key}) : super(key: key);

  @override
  _SkinCancerScreenState createState() => _SkinCancerScreenState();
}

class _SkinCancerScreenState extends State<SkinCancerScreen> {

  File? image;
  List? _result;
  bool isImageLoaded = false;

  String _confidence = "";
  String _name = "";
  //String numbers = "";

  final picker = ImagePicker();
  final _loading = Loading();

  @override
  void initState() {
    super.initState();
    _loading.loadMyModel().then((value) {
      print("loaded screen 1");
      setState(() {});
    });
  }

  void applyModel() async {
    image = await _loading.getImageFromGallery(picker);
      if(image == null) {
        print("Image null is true");
        isImageLoaded = false;

      } else {
        isImageLoaded = true;
        _result = await _loading.applyModelOnImage(image!);
        if (_result != null) {
            _name = _result![1];
        } else {
            print("Null result after applying model");
        }
      }
    setState(() {
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Test"),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              applyModel();
            },
            child: Icon(Icons.photo_album),
          ),

          body: Container(
            child: Column(
              children: [
                SizedBox(height: 80),
                isImageLoaded
                    ? Center(
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        image:  DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.contain)),
                  ),
                )
                    : Center(
                    child: Text("No image"),
                ),
                Text("Name : $_name\n Confidence: $_confidence"),
                Text("isImageLoaded: $isImageLoaded"),
              ],
            ),
          ),
    );
  }
}
