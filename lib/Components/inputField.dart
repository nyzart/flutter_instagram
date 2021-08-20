import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final type;
  final icon;
  final onSaved;
  final multiline;
  InputField({this.type, this.icon, this.onSaved, this.multiline = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ' + type;
        }
        return null;
      },
      keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
      maxLines: multiline ? null : 1,
      onSaved: onSaved,
      obscureText: type == 'password',
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: 'Enter your ' + type,
        fillColor: Colors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
