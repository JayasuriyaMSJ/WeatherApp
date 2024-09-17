import 'package:flutter/material.dart';
import 'package:intern_weather/core/utils/snack_bar.dart';

class Authfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obSecureText;
  final ValueChanged fun;
  final GestureTapCallback tapFun;
  final TapRegionCallback tapOut;
  final FormFieldSetter onSaved;
  final GestureTapCallback onEditingComplete;
  final ValueChanged onFieldSubmitted;
  final FocusNode onFocus;

  const Authfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obSecureText = false,
    required this.fun,
    required this.tapFun,
    required this.tapOut,
    required this.onSaved,
    required this.onEditingComplete,
    required this.onFieldSubmitted,
    required this.onFocus,
  });

  @override
  Widget build(BuildContext context) {
    // Define dynamic border color based on the current theme
    final Color borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70 // Light color for dark mode
        : Colors.black54; // Darker color for light mode

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Search by city Name...',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade700),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade700, width: 2),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        suffixIcon: const Icon(
          Icons.search_rounded,
        ),
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          showSnackBar(context, "Please enter the $hintText");
          return hintText;
        } else {
          return null;
        }
      },
      focusNode: onFocus,
      obscureText: obSecureText,
      onChanged: fun,
      onTap: tapFun,
      onTapOutside: tapOut,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
