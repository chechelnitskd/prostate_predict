import 'package:flutter/material.dart';

typedef Validator<T> = String? Function(T a);
typedef Saver<T> = void Function(T a);

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
            builder: (FormFieldState<int> state) {
              return Column(
                children: <Widget>[
                  Text("Age:"),
                  Text(state.value.toString()),
                  Slider.adaptive(
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
            });
}
