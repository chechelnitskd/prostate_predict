import 'package:flutter/material.dart';

class SliderFormField extends FormField<int> {
  SliderFormField({
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    int initialValue = 0,
    //bool autovalidate = false
  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      //autovalidate: autovalidate,
      builder: (FormFieldState<int> state) {
        return
          Slider(
            min: 0,
            max: 100,
            value: state.value!.toDouble(),
            //label: _value.round().toString(), // label not working
            onChanged: (value) {
              state.didChange(value.round());
            },
          );
        /*Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                state.didChange(state.value! - 1);
              },
            ),
            Text(
                state.value.toString()
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                state.didChange(state.value! + 1);
              },
            ),
          ],
        );*/
      }
  );
}

/*
Slider(
                  min: 0,
                  max: 100,
                  value: _value,
                  //label: _value.round().toString(), // label not working
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
 */