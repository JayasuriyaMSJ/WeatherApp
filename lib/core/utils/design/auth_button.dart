import 'package:flutter/material.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';

class Authbutton extends StatelessWidget {
  final String content;
  final VoidCallback onpressed;
  const Authbutton({super.key, required this.content, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppColorPalette.buttonGradientStart,
            AppColorPalette.buttonGradientEnd,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(20)),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 55),
            backgroundColor: AppColorPalette.transperent,
            shadowColor: AppColorPalette.transperent),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColorPalette.white,
          ),
        ),
      ),
    );
  }
}
