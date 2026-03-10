// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

import 'package:flutter_svg/svg.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    super.key,
    this.width,
    this.height,
    this.callTypes,
  });

  final double? width;
  final double? height;
  final int? callTypes;

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    );

    // Left to right (0 to -π), then right to left (-π to 0)
    _rotationAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -pi, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    if (widget.callTypes == 1) {
      // Delay 2 seconds before starting
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) _controller.forward();
      });
    } else {
      // Start immediately
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.repeat(); // repeat indefinitely for continuous animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(_rotationAnimation.value),
          child: child,
        );
      },
      child: SvgPicture.asset(
        'assets/images/logoSvg.svg',
        width: 144,
        height: 144,
        fit: BoxFit.contain,
      ),
    );
  }
}
