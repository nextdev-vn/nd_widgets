import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDSegmentTabs extends StatefulWidget {
  const NDSegmentTabs({
    Key? key,
    required this.length,
    required this.tabs,
    required this.tabController,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.tabBarColor,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  })  : assert(length != null && length >= 0),
        super(key: key);

  final int? length;

  final double? height;

  final Color? tabBarColor;

  final Color? indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Decoration? indicator;

  final TabBarIndicatorSize? indicatorSize;

  final Color? labelColor;

  final Color? unselectedLabelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final TextStyle? unselectedLabelStyle;

  final List<Widget> tabs;

  final Border? border;

  final BorderRadius? borderRadius;

  final TabController? tabController;

  final double? width;

  @override
  _NDSegmentTabsState createState() => _NDSegmentTabsState();
}

class _NDSegmentTabsState extends State<NDSegmentTabs> {
  @override
  Widget build(BuildContext context) => Container(
        height: widget.height ?? 28,
        width: widget.width ?? 240,
        decoration: BoxDecoration(
          border:
              widget.border ?? Border.all(color: NDColors.PRIMARY, width: 1),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(2),
        ),
        child: DefaultTabController(
          length: widget.length!,
          child: Material(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(2),
            type: MaterialType.button,
            color: widget.tabBarColor ?? Colors.transparent,
            child: TabBar(
              controller: widget.tabController,
              labelColor: widget.labelColor ?? NDColors.WHITE,
              unselectedLabelColor:
                  widget.unselectedLabelColor ?? NDColors.PRIMARY,
              labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 12),
              unselectedLabelStyle:
                  widget.unselectedLabelStyle ?? const TextStyle(fontSize: 12),
              indicatorColor: widget.indicatorColor ?? NDColors.PRIMARY,
              indicatorSize: widget.indicatorSize,
              indicator: widget.indicator ??
                  BoxDecoration(
                    color: widget.indicatorColor ?? NDColors.PRIMARY,
                    border: Border.all(
                        color: widget.indicatorColor ?? Colors.transparent,
                        width: 2),
                    borderRadius: widget.borderRadius == null
                        ? BorderRadius.circular(0)
                        : widget.borderRadius,
                  ),
              indicatorPadding: widget.indicatorPadding,
              indicatorWeight: widget.indicatorWeight,
              tabs: widget.tabs,
            ),
          ),
        ),
      );
}
