import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prostate_predict/data/data_constants.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:prostate_predict/functions/loading.dart';
import 'package:prostate_predict/widgets/homepage_widgets.dart';
import 'package:prostate_predict/widgets/screen_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loading.loadMyModel().then((value) {
      print("loaded screen 1");
      setState(() {});
    });
  }

  void _saveSCToHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool(skinCancer, true);
      Provider.of<UserHistory>(context, listen: false)
          .save(
          RiskCalculatorType.SKIN_CANCER,
          100.0);
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
      if (isImageLoaded) {
        _saveSCToHistory();
        Provider.of<History>(context, listen: false).updateSCRiskSharedPreferences();
      }
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
      key: _key,
      appBar: ColorAppBar(context, _key),
      endDrawer: buildSideBar(context),

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
                //Text("Name : $_name\n Confidence: $_confidence"),
                Text("isImageLoaded: $isImageLoaded"),
              ],
            ),
          ),
    );
  }
}
