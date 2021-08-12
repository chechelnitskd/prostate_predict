import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../functions/calculations.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';
import 'results_screen.dart';
import 'package:provider/provider.dart';
import '../data/user_data.dart';
import 'package:health/health.dart';
import '../widgets/form_fields.dart';
import '../functions/loading.dart';
import 'home_page.dart';
import '../widgets/screen_widgets.dart';

enum FormScreenState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}


class FormScreen extends StatelessWidget {
  // THE MENU IS NOT WORKING HERE! b/c it's stateless?
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ColorAppBar(context, _key),
      endDrawer: SideBar(context),
      body: MyCustomForm(),
      backgroundColor: Colors.pink[50],
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

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
      _formKey.currentState!.save();
      Navigator.pushNamed(
          context,
        'results'
      );
    }
  }

  String? _validateAge(int? age) {
    RegExp regex = RegExp(r'[1-9]\d*(\.\d+)?');
    if (age == null) {
      return 'Please enter age';
    } else if (!regex.hasMatch(age.toString())) {
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
    } else if (!regex.hasMatch(psa)) {
      return 'Please enter PSA as a number';
    } else {
      return null;
    }
  }

  void _saveAge(int? age) {
    Provider.of<UserData>(context, listen: false).setAge(age!);
  }

  void _savePSA(String? psa) {
    Provider.of<UserData>(context, listen: false).setPSA(int.parse(psa!));
  }


  void fetchData() {
    _loadTest.fetchDataLoading().then( (value) {
      setState(() {
        Provider.of<UserData>(context, listen: false)
            .setList(value);
        _state = Provider.of<UserData>(context, listen: false)
            .getList().isEmpty
            ? FormScreenState.NO_DATA
            : FormScreenState.DATA_READY;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SliderFormField(onSaved: _saveAge),
              createTextFormField(
                  _psaController, "PSA", _validatePSA, _savePSA),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
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
