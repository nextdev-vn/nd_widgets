import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDTabBar extends StatefulWidget {
  const NDTabBar({
    Key? key,
    required this.length,
    required this.tabs,
    required this.controller,
    this.isScrollable = false,
    this.tabBarHeight,
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
    this.shape,
    this.width,
  })  : assert(length != null && length >= 0),
        super(key: key);

  final int? length;

  final double? tabBarHeight;

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

  final bool isScrollable;

  final TabController? controller;

  final ShapeBorder? shape;

  final double? width;

  @override
  _NDTabBarState createState() => _NDTabBarState();
}

class _NDTabBarState extends State<NDTabBar> {
  ScrollController? _scrollController;
  DragStartBehavior dragStartBehavior = DragStartBehavior.start;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        dragStartBehavior: dragStartBehavior,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height:
              widget.tabBarHeight ?? MediaQuery.of(context).size.height * 0.1,
          child: Material(
            shape: widget.shape,
            type: MaterialType.button,
            color: widget.tabBarColor ?? NDColors.PRIMARY,
            child: TabBar(
              isScrollable: widget.isScrollable,
              controller: widget.controller,
              labelColor: widget.labelColor,
              unselectedLabelColor: widget.unselectedLabelColor,
              labelStyle: widget.labelStyle,
              unselectedLabelStyle: widget.unselectedLabelStyle,
              indicatorColor: widget.indicatorColor,
              indicatorSize: widget.indicatorSize,
              indicator: widget.indicator,
              indicatorPadding: widget.indicatorPadding,
              indicatorWeight: widget.indicatorWeight,
              tabs: widget.tabs,
            ),
          ),
        ),
      );
}
