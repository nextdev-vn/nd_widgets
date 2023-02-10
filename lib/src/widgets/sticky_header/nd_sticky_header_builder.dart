import 'package:flutter/material.dart';

import '../../constants/position/nd_position.dart';
import 'nd_sticky_header.dart';
import 'render_nd_sticky_header.dart';

typedef StickyHeaderWidgetBuilder = Widget Function(
  BuildContext context,
  double stuckValue,
);

class NDStickyHeaderBuilder extends StatefulWidget {
  const NDStickyHeaderBuilder({
    Key? key,
    required this.stickyContentBuilder,
    required this.content,
    this.direction = Axis.vertical,
    this.enableHeaderOverlap = false,
    this.callback,
    this.stickyContentPosition = NDPosition.start,
  }) : super(key: key);

  final StickyHeaderWidgetBuilder stickyContentBuilder;

  final Widget content;

  final bool enableHeaderOverlap;

  final NDPosition stickyContentPosition;

  final RenderNDStickyHeaderCallback? callback;

  final Axis direction;

  @override
  _NDStickyHeaderBuilderState createState() => _NDStickyHeaderBuilderState();
}

class _NDStickyHeaderBuilderState extends State<NDStickyHeaderBuilder> {
  double? _stuckValue;

  @override
  Widget build(BuildContext context) => NDStickyHeader(
        enableHeaderOverlap: widget.enableHeaderOverlap,
        direction: widget.direction,
        stickyContentPosition: widget.stickyContentPosition,
        stickyContent: LayoutBuilder(
          builder: (context, _) =>
              widget.stickyContentBuilder(context, _stuckValue ?? 0.0),
        ),
        content: widget.content,
        callback: (double stuckValue) {
          if (_stuckValue != stuckValue) {
            _stuckValue = stuckValue;
            WidgetsBinding.instance.endOfFrame.then((_) {
              if (mounted) {
                setState(() {});
              }
            });
          }
        },
      );
}
