import 'package:flutter/material.dart';

import '../../constants/types/nd_border_type.dart';
import 'nd_dashed_border.dart';

class NDBorder extends StatelessWidget {
  NDBorder({
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1,
    this.type = NDBorderType.rect,
    this.dashedLine = const <double>[3, 1],
    this.padding = const EdgeInsets.all(10),
    this.radius = const Radius.circular(0),
  }) : assert(_isValidDashedLine(dashedLine), 'Invalid dash pattern');

  final Widget child;

  final EdgeInsets padding;

  final double strokeWidth;

  final Color color;

  final List<double> dashedLine;

  final NDBorderType type;

  final Radius radius;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: DashedType(
                strokeWidth: strokeWidth,
                radius: radius,
                color: color,
                type: type,
                dashedLine: dashedLine,
              ),
            ),
          ),
          Container(padding: padding, child: child),
        ],
      );
}

bool _isValidDashedLine(List<double> dash) {
  final Set<double> _dashSet = dash.toSet();

  if (_dashSet.length == 1 && _dashSet.elementAt(0) == 0.0) {
    return false;
  }
  if (_dashSet.isEmpty) {
    return false;
  }
  return true;
}
