import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';


class SkinCancerScreen2 extends StatefulWidget {
  @override
  _SkinCancerScreen2State createState() => _SkinCancerScreen2State();
}

class _SkinCancerScreen2State extends State<SkinCancerScreen2> {

  File? _image;
  List? _result;
  bool _isImageLoaded = false;

  String _confidence = "";
  String _name = "";
  //String numbers = "";

  final _picker = ImagePicker();

  loadMyModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print("Loaded");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );

    setState(() {
      _result = res;
      String str = _result![0]['label'];
      _name = str.substring(2);
      _confidence = (_result![0]['confidence']*100.0).toString().substring(0,2) + "%";
    });
  }

  Future getImageFromGallery() async {
    print("before await");
    var tempStore = await _picker.getImage(source: ImageSource.gallery);
    print("after await");

    setState(() {
      if (tempStore == null) {
        print("no image loaded\nImage null? ${_image == null}");
        return;
      } else {
        _isImageLoaded = true;
        _image = File(tempStore.path);
        print("Image null? ${_image == null}");
        applyModelOnImage(_image!);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyModel().then((value) {
      setState(() {});
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
              getImageFromGallery();
            },
            child: Icon(Icons.photo_album),
          ),

          body: Container(
            child: Column(
              children: [
                SizedBox(height: 80),
                _isImageLoaded
                    ? Center(
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        image:  DecorationImage(
                            image: FileImage(File(_image!.path)),
                            fit: BoxFit.contain)),
                  ),
                )
                    : Center(
                    child: Text("No image"),
                ),
                Text("Name : $_name\n Confidence: $_confidence"),
                Text("isImageLoaded: $_isImageLoaded"),
              ],
            ),
          ),
        );
  }
}
