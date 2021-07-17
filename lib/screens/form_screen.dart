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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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
            validator: (value) {
              if (value == null || value.isEmpty || num.tryParse(value) == null) {
                return 'Please enter age as a number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _psaController, keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Your PSA",
                labelText: "PSA",
                labelStyle: TextStyle(fontSize: 24),
                border: InputBorder.none),
            // The validator receives the text that the user has entered.
            validator: (value) {
              // this doesn't work!
              if (value == null || value.isEmpty || num.tryParse(value) == null) {
                return 'Please enter PSA as a number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<UserData>(context, listen: false)
                    .setAge(int.parse(_ageController.text));
                Provider.of<UserData>(context, listen: false)
                    .setPSA(int.parse(_psaController.text));
                Navigator.push(
                  context,
                  //new MaterialPageRoute(
                  MaterialPageRoute(
                      builder: (context) => ResultsScreen()), // instead of new ResultsScreen()
                );
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
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

