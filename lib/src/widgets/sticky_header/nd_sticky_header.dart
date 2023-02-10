import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/position/nd_position.dart';
import 'render_nd_sticky_header.dart';

class NDStickyHeader extends MultiChildRenderObjectWidget {
  NDStickyHeader(
      {Key? key,
      required this.stickyContent,
      required this.content,
      this.direction = Axis.vertical,
      this.enableHeaderOverlap = false,
      this.callback,
      this.stickyContentPosition = NDPosition.start})
      : super(
            key: key,
            children: stickyContentPosition == NDPosition.start &&
                    direction == Axis.horizontal
                ? [stickyContent, content]
                : stickyContentPosition == NDPosition.start &&
                        direction == Axis.vertical
                    ? [content, stickyContent]
                    : [content, stickyContent]);

  final Widget stickyContent;

  final Widget content;

  final bool enableHeaderOverlap;

  final NDPosition stickyContentPosition;

  final RenderNDStickyHeaderCallback? callback;

  final Axis direction;

  @override
  RenderNDStickyHeader createRenderObject(BuildContext context) {
    final scrollable = Scrollable.of(context)!;
    return RenderNDStickyHeader(
      direction: direction,
      scrollable: scrollable,
      enableHeaderOverlap: enableHeaderOverlap,
      callback: callback,
      stickyContentPosition: stickyContentPosition,
    );
  }
}
