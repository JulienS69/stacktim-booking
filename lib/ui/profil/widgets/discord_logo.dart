import 'package:flutter/widgets.dart';
import 'package:stacktim_booking/helper/strings.dart';

class DiscordRotating extends StatefulWidget {
  const DiscordRotating({super.key});

  @override
  DiscordRotatingState createState() => DiscordRotatingState();
}

class DiscordRotatingState extends State<DiscordRotating>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: RotationTransition(
          turns: _animation,
          child: Image.asset(
            discord,
            height: 25,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
