import 'package:flutter/material.dart';
import 'package:mobile/core/config/monitor.dart';
import 'package:mobile/core/widgets/restrictor/line.dart';

class TextLine extends Line {
  final String text;
  final TextStyle textStyle;

  const TextLine({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(),
    super.width = 0,
    super.stroke,
    super.color,
    super.dashSpacing,
    super.dashLength,
  });

  Expanded _buildLine(double widthLine) {
    return Expanded(
      child: CustomPaint(
        size: Size(widthLine, stroke),
        painter: LinePainter(
          stroke: stroke,
          color: color,
          dashSpacing: dashSpacing,
          dashLength: dashLength,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 8;
    double widthLine = 0;
    if (width == 0) {
      widthLine = (Monitor.width / 2);
    } else {
      widthLine = width;
    }

    return Row(
      children: [
        _buildLine(widthLine),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(
            text,
            style: textStyle,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildLine(widthLine),
      ],
    );
  }
}
