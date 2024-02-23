import 'package:flutter/widgets.dart';

enum ChevronDirection { up, down, right, left }

class Chevron extends StatelessWidget {
  final ChevronDirection direction;
  final double size;
  final Color color;

  const Chevron({
    Key? key,
    required this.direction,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ChevronPainter(direction, color),
    );
  }
}

class ChevronPainter extends CustomPainter {
  final ChevronDirection direction;
  final Color color;

  ChevronPainter(this.direction, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    Path path = Path();

    switch (direction) {
      case ChevronDirection.up:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(size.width / 2, size.height);
        break;
      case ChevronDirection.down:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(size.width / 2, size.height);
        break;
      case ChevronDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case ChevronDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height / 2);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChevronPainter oldDelegate) {
    return oldDelegate.direction != direction || oldDelegate.color != color;
  }
}
