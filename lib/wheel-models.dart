import 'dart:math';

import 'package:flutter/material.dart';

double eightWheelCenterRadius = 103;
double eightWheelPieceSize = 174;

class FourWheelPainter extends CustomPainter {
  const FourWheelPainter({required this.isActive});

  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    var borderColor = Colors.white.withOpacity(0.7);
    var borderWidth = 2.0;
    if (isActive) {
      borderColor = Colors.white;
      borderWidth = 10;
    } else {
      borderColor = Colors.white.withOpacity(0.7);
      borderWidth = 4;
    }
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.moveTo(0, 0);
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(0, h - eightWheelCenterRadius),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = borderColor;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class FourWheelPieceShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(0, h - eightWheelCenterRadius),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class FourWheelInkWellShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  final w = eightWheelPieceSize;
  final h = eightWheelPieceSize;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    path.moveTo(w / sqrt(2), h - h / sqrt(2));
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(eightWheelCenterRadius / sqrt(2), h - eightWheelCenterRadius / sqrt(2)),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    path.moveTo(w / sqrt(2), h - h / sqrt(2));
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(eightWheelCenterRadius / sqrt(2), h - eightWheelCenterRadius / sqrt(2)),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  ShapeBorder scale(double t) => FourWheelInkWellShape();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    path.moveTo(w / sqrt(2), h - h / sqrt(2));
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(eightWheelCenterRadius / sqrt(2), h - eightWheelCenterRadius / sqrt(2)),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();
    canvas.rotate(pi / 4);
    canvas.drawPath(path, Paint());
  }
}

class EightWheelPieceShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    path.moveTo(w / sqrt(2), h - h / sqrt(2));
    path.arcToPoint(Offset(w, h), radius: Radius.circular(eightWheelPieceSize));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(eightWheelCenterRadius / sqrt(2), h - eightWheelCenterRadius / sqrt(2)),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

//not used
class EightWheelPainter extends CustomPainter {
  EightWheelPainter({required this.isActive});

  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    var borderColor = Colors.white.withOpacity(0.7);
    var borderWidth = 2.0;
    if (isActive) {
      borderColor = Colors.white;
      borderWidth = 10;
    } else {
      borderColor = Colors.white.withOpacity(0.7);
      borderWidth = 4;
    }
    borderColor = Colors.green;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = borderColor;
    final w = eightWheelPieceSize;
    final h = eightWheelPieceSize;
    final path = Path();

    path.moveTo(w / sqrt(2), h - h / sqrt(2));
    path.arcToPoint(Offset(w, h), radius: Radius.circular(w));
    path.lineTo(eightWheelCenterRadius, h);
    path.arcToPoint(
      Offset(eightWheelCenterRadius / sqrt(2), h - eightWheelCenterRadius / sqrt(2)),
      radius: Radius.circular(eightWheelCenterRadius),
      clockwise: false,
    );
    path.lineTo(w / sqrt(2), h - h / sqrt(2));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


const double fourWheelCenterRadius = 103;
const double fourWheelPieceSize = 174;
const double iconBoxSize = 60;
