import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../calculations.dart';
import 'results_screen.dart';
import 'package:provider/provider.dart';
import '../user_data.dart';

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
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

// need to make the fields required
// also, this stores te same values/doesn't call again when you click back

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _ageController = TextEditingController();
  TextEditingController _psaController = TextEditingController();
  TextEditingController _tStgController = TextEditingController();
  TextEditingController _gGController = TextEditingController();
  TextEditingController _trTController = TextEditingController();
  TextEditingController _ppcBController = TextEditingController();
  TextEditingController _brcaController = TextEditingController();
  TextEditingController _comoController = TextEditingController();


  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // what exactly does saving do?
      // it calls onSaved: ... for each field (so we have to write it!)
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      Navigator.push(
        context,
        //new MaterialPageRoute(
        MaterialPageRoute(
            builder: (context) => ResultsScreen()), // instead of new ResultsScreen()
      );
    }
  }

  // might need to be a texteditingcontroller?
  // string? works
  String? _validateAge(String? age) {
    RegExp regex = RegExp(r'[1-9]\d*(\.\d+)?');
    if (age == null || age.isEmpty) {
      return 'Please enter age';
    } else if (!regex.hasMatch(age)){
      return 'Please enter age as a number';
    } else {
      return null;
    }
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


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    // don't need to make it a Scaffold again  b/c FormScreen is a scaffold
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          //padding: const EdgeInsets.symmetric(vertical: 16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Your Age",
                  labelText: "Age",
                  labelStyle: TextStyle(fontSize: 24),
                  border: InputBorder.none),
              // The validator receives the text that the user has entered.
              validator: _validateAge,
              onSaved: (value) {
                Provider.of<UserData>(context, listen: false)
                    .setAge(int.parse(_ageController.text));
              },
            ),

            TextFormField(
              controller: _psaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Your PSA",
                  labelText: "PSA",
                  labelStyle: TextStyle(fontSize: 24),
                  border: InputBorder.none),
              // The validator receives the text that the user has entered.
              validator: _validatePSA,
              onSaved: (value) {
                Provider.of<UserData>(context, listen: false)
                    .setPSA(int.parse(_psaController.text));
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child:
              ElevatedButton(
                onPressed: () => _submit(context),
                /*() {
                  _submit();
                  Navigator.push(
                    context,
                    //new MaterialPageRoute(
                    MaterialPageRoute(
                        builder: (context) => ResultsScreen()), // instead of new ResultsScreen()
                  );
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },*/
                child: Text('Submit'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ),
          ],
        ),
        ),
    );
  }

}

