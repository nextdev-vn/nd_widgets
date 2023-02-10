import 'package:flutter/material.dart';

class NDButtonBar extends StatelessWidget {
  const NDButtonBar({
    Key? key,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.spacing = 8.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    required this.children,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  final EdgeInsetsGeometry padding;

  final Axis direction;

  final WrapAlignment alignment;

  final double spacing;

  final WrapAlignment runAlignment;

  final double runSpacing;

  final List<Widget> children;

  final WrapCrossAlignment crossAxisAlignment;

  final TextDirection? textDirection;

  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Wrap(
          direction: direction,
          alignment: alignment,
          spacing: spacing,
          runAlignment: runAlignment,
          runSpacing: runSpacing,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          children: children.map<Widget>((Widget child) => child).toList(),
        ),
      );
}
