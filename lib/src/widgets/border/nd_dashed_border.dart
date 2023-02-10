import 'dart:ui';
import 'package:flutter/material.dart';

import '../../constants/types/nd_border_type.dart';

typedef PathBuilder = Path Function(Size);

class DashedType extends CustomPainter {
  DashedType({
    this.strokeWidth = 2,
    this.dashedLine = const <double>[3, 1],
    this.color = Colors.black,
    this.type = NDBorderType.rect,
    this.radius = const Radius.circular(0),
    this.customPath,
  }) : assert(dashedLine.isNotEmpty, 'dash line cannot be empty');

  final double strokeWidth;

  final List<double> dashedLine;

  final Color color;

  final NDBorderType type;

  final Radius radius;

  final PathBuilder? customPath;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    Path? _path;
    if (customPath != null) {
      _path = dashPath(
        customPath!(size),
        dashedarray: CircularIntervalList(dashedLine),
      );
    } else {
      _path = _getPath(size);
    }
    if (_path != null) {
      canvas.drawPath(_path, paint);
    }
  }

  Path? _getPath(Size size) {
    Path path;
    switch (type) {
      case NDBorderType.circle:
        path = _getCirclePath(size);
        break;
      case NDBorderType.rRect:
        path = _getRRectPath(size, radius);
        break;
      case NDBorderType.rect:
        path = _getRectPath(size);
        break;
      case NDBorderType.oval:
        path = _getOvalPath(size);
        break;
    }
    return dashPath(path, dashedarray: CircularIntervalList(dashedLine));
  }

  Path _getCirclePath(Size size) {
    final double width = size.width;
    final double height = size.height;
    final double sizes = size.shortestSide;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            width > sizes ? (width - sizes) / 2 : 0,
            height > sizes ? (height - sizes / 2) : 0,
            sizes,
            sizes,
          ),
          Radius.circular(sizes / 2),
        ),
      );
  }

  Path _getRRectPath(Size size, Radius radius) => Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
        radius,
      ),
    );

  Path _getRectPath(Size size) => Path()
    ..addRect(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
    );

  Path _getOvalPath(Size size) => Path()
    ..addOval(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
    );

  @override
  bool shouldRepaint(DashedType oldDelegate) =>
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.color != color ||
      oldDelegate.dashedLine != dashedLine ||
      oldDelegate.type != type;
}

class CircularIntervalList<T> {
  CircularIntervalList(this.values);
  final List<T> values;
  int index = 0;
  T get next {
    if (index >= values.length) {
      index = 0;
    }
    return values[index++];
  }
}

Path? dashPath(Path? source,
    {required CircularIntervalList<double> dashedarray,
    DashOffset dashOffset = const DashOffset.absolute(0)}) {
  if (source == null) {
    return null;
  }
  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    bool draw = true;
    while (distance < metric.length) {
      final double len = dashedarray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }
  return dest;
}

enum _DashOffsetType { absolute, percentage }

class DashOffset {
  DashOffset.percentage(double percentage)
      : _value = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.percentage;

  const DashOffset.absolute(double start)
      : _value = start,
        _dashOffsetType = _DashOffsetType.absolute;

  final double _value;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) =>
      _dashOffsetType == _DashOffsetType.absolute ? _value : length * _value;
}
