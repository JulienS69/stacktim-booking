import 'package:flutter/material.dart';
import 'package:stacktim_booking/helper/strings.dart';

class XLoaderStacktim extends StatefulWidget {
  final Color? backgroundColor;
  final String? imagePath;
  const XLoaderStacktim({super.key, this.backgroundColor, this.imagePath});

  @override
  XLoaderStacktimState createState() => XLoaderStacktimState();
}

class XLoaderStacktimState extends State<XLoaderStacktim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1750));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            color: widget.backgroundColor,
            child: CircularProgressIndicator(
              backgroundColor: widget.backgroundColor,
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            widget.imagePath ?? logoOverSlug,
            height: 50,
            width: 75,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
