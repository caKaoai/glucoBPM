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

import 'package:flutter/services.dart';

class SwipeToDelete extends StatefulWidget {
  const SwipeToDelete({
    super.key,
    this.width,
    this.height,
    this.uiComponent,
    this.index,
    this.storedIndex,
    this.ondelete,
    this.onSwipeOpen,
  });

  final double? width;
  final double? height;
  final Widget Function()? uiComponent;
  final int? index;
  final int? storedIndex;
  final Future Function()? ondelete;
  final Future Function(int? index)? onSwipeOpen;

  @override
  State<SwipeToDelete> createState() => _SwipeToDeleteState();
}

class _SwipeToDeleteState extends State<SwipeToDelete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _isDeleting = 0;
  double offsetX = 0.0;
  final double maxDrag = -80.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() => offsetX = _animation.value);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateTo(double target) {
    _animation = Tween<double>(begin: offsetX, end: target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() => offsetX = _animation.value);
      });

    _controller.forward(from: 0);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      offsetX += details.delta.dx;
      if (offsetX < maxDrag) offsetX = maxDrag;
      if (offsetX > 0) offsetX = 0;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (offsetX < maxDrag / 2) {
      animateTo(maxDrag);
      widget.onSwipeOpen?.call(widget.index);
    } else {
      _close();
    }
  }

  void _close() {
    animateTo(0);
  }

  @override
  void didUpdateWidget(covariant SwipeToDelete oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Close if another item is opened
    if (widget.storedIndex != widget.index && offsetX != 0.0) {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Delete background
        Positioned.fill(
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: const Color(0xFFFF3400),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: _isDeleting == 1
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 27,
                    ),
              onPressed: () async {
                if (_isDeleting == 1) return;
                if (widget.storedIndex == widget.index) {
                  setState(() => _isDeleting = 1);
                  await HapticFeedback.heavyImpact();
                  await widget.ondelete?.call();
                  setState(() => _isDeleting = 0);
                  _close();
                }
                FFAppState().update(
                  () {},
                );
              },
            ),
          ),
        ),

        // Foreground content (dynamic height)
        Transform.translate(
          offset: Offset(offsetX, 0),
          child: GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onTap: _close,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: widget.uiComponent?.call() ?? const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
