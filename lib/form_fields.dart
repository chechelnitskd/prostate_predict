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
          Column(
            children: <Widget>[
              Text("Age:"),
              Text(
                state.value.toString()),
              Slider(
                min: 0,
                max: 100,
                value: state.value!.toDouble(),
                //label: _value.round().toString(), // label not working
                onChanged: (value) {
                  state.didChange(value.round());
                },
              ),
            ],
          );
      }
  );
}
