import 'package:flutter/material.dart';

class XBouncingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const XBouncingButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  @override
  State<XBouncingButton> createState() => _XBouncingButtonState();
}

class _XBouncingButtonState extends State<XBouncingButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
        widget.onPressed();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
