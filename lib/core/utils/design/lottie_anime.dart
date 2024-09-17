// Service for the serving the Gif
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final String fileName;
  final bool play;
  final bool continuousPlay;
  final double wid;
  final double hei;

  const LottieAnimation({super.key,
    required this.fileName,
    required this.play,
    required this.continuousPlay,
    required this.wid,
    required this.hei,
    // TODO: Need to add the size of the gif in parameter
  });

  @override
  _LottieAnimationState createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _isPlaying = widget.play;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _isPlaying = !_isPlaying;
        // });
      },
      child: Lottie.asset(
        widget.fileName,
        repeat: widget.continuousPlay ? true : false,
        animate: _isPlaying,
        width: widget.wid,
        height: widget.hei,
      ),
    );
  }
}