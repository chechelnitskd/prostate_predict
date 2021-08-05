import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../functions/calculations.dart';
import 'results_screen.dart';
import 'package:provider/provider.dart';
import '../data/user_data.dart';
import 'package:health/health.dart';
import '../widgets/form_fields.dart';
import '../functions/loading.dart';

enum FormScreenState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

typedef Validator<T> = String? Function(T a);
typedef Saver<T> = void Function(T a);

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Prostate Cancer Risk'),
        backgroundColor: Colors.red,
      ),
      body: MyCustomForm(),
      backgroundColor: Colors.pink[50],
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  FormScreenState _state = FormScreenState.DATA_NOT_FETCHED;

  final Loading _loadTest = Loading();

  TextEditingController _ageController = TextEditingController();
  TextEditingController _psaController = TextEditingController();
  /*TextEditingController _tStgController = TextEditingController();
  TextEditingController _gGController = TextEditingController();
  TextEditingController _trTController = TextEditingController();
  TextEditingController _ppcBController = TextEditingController();
  TextEditingController _brcaController = TextEditingController();
  TextEditingController _comoController = TextEditingController();*/



  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // saving calls onSaved: ... for each field (so we have to write it!)
      _formKey.currentState!.save();
      Navigator.push(
        context,
        //TO DO: change to named navigation
        MaterialPageRoute(
            builder: (context) => ResultsScreen()), // instead of new ResultsScreen()
      );
    }
  }

  String? _validateAge(int? age) {
    RegExp regex = RegExp(r'[1-9]\d*(\.\d+)?');
    if (age == null) {
      return 'Please enter age';
    } else if (!regex.hasMatch(age.toString())){
      return 'Please enter age as a number';
    } else {
      return null;
    }
    /*
    if (value != null && (value < 35 || value > 95)) {
                      return 'Model only accurate for ages 35-95';
                    }
     */
  }

  String? _validatePSA(String? psa) {
    RegExp regex = RegExp(r'[1-9]\d*(\.\d+)?');
    // trying new regex with no ^ and $
    if (psa == null || psa.isEmpty) {
      return 'Please enter PSA';
    } else if (!regex.hasMatch(psa)){
      return 'Please enter PSA as a number';
    } else {
      return null;
    }
  }

  void _saveAge(int? age) {
    Provider.of<UserData>(context, listen: false)
        .setAge(age!);
  }

  void _savePSA(String? psa) {
    Provider.of<UserData>(context, listen: false)
        .setPSA(int.parse(psa!));
  }

  Widget createTextFormField(TextEditingController ctrlr, String field,
      Validator<String?> validator, Saver<String?> saver) {
    return
      TextFormField(
        controller: ctrlr,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: "Your " + field,
            labelText: field,
            labelStyle: TextStyle(fontSize: 24),
            border: InputBorder.none),
        validator: validator,
        onSaved: saver,
      );
  }

  void fetchData() {
    _loadTest.fetchDataLoading().then( (value) {
      setState(() {
        Provider.of<UserData>(context, listen: false)
            .setList(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    //_loadTest.fetchData(); <-- need to do this when setting state
    //print(_loadTest.healthDataList);
    return
    // try the SafeArea -- not sure if it makes a difference
      SafeArea(
          child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            //padding: const EdgeInsets.symmetric(vertical: 16.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                ElevatedButton(
                    onPressed: fetchData,
                    child: Text("test")),
                SliderFormField(
                  onSaved: _saveAge
                ),
                createTextFormField(_psaController, "PSA", _validatePSA, _savePSA),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child:
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text('Submit'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
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



