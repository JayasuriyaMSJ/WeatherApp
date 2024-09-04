import 'package:flutter/material.dart';
import 'package:intern_weather/core/utils/snack_bar.dart';

class Authfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obSecureText;

  const Authfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obSecureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          showSnackBar(context, "Plz Enter the $hintText");
          return hintText;
        } else {
          return null;
        }
      },
      obscureText: obSecureText,
    );
  }
}
