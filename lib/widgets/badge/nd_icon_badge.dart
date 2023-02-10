import 'package:flutter/material.dart';

import '../../constants/position/nd_badge_position.dart';

class NDIconBadge extends StatefulWidget {
  const NDIconBadge(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 8),
      required this.child,
      required this.counterChild,
      this.position})
      : super(key: key);

  final Widget child;

  final Widget counterChild;

  final EdgeInsetsGeometry padding;

  final NDBadgePosition? position;

  @override
  _NDIconBadgeState createState() => _NDIconBadgeState();
}

class _NDIconBadgeState extends State<NDIconBadge> {
  @override
  Widget build(BuildContext context) => Container(
      padding: widget.padding,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          widget.child,
          widget.position == null
              ? PositionedDirectional(
                  top: NDBadgePosition.topEnd().top,
                  end: NDBadgePosition.topEnd().end,
                  child: widget.counterChild,
                )
              : PositionedDirectional(
                  top: widget.position!.top,
                  end: widget.position!.end,
                  bottom: widget.position!.bottom,
                  start: widget.position!.start,
                  child: widget.counterChild,
                )
        ],
      ));
}
