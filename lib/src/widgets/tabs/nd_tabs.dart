import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import 'nd_tabbar.dart';
import 'nd_tabbar_view.dart';

class NDTabs extends StatefulWidget {
  const NDTabs({
    Key? key,
    this.initialIndex = 0,
    required this.length,
    required this.tabs,
    required this.tabBarView,
    required this.controller,
    this.isScrollable = false,
    this.height,
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
    this.tabBarHeight,
    this.shape,
  })  : assert(length >= 0),
        assert(initialIndex != null &&
            initialIndex >= 0 &&
            (length == 0 || initialIndex < length)),
        super(key: key);

  final int? initialIndex;

  final int length;

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

  final NDTabBarView tabBarView;

  final List<Widget> tabs;

  final TabController controller;

  final double? tabBarHeight;

  final ShapeBorder? shape;

  final bool isScrollable;

  @override
  _NDTabsState createState() => _NDTabsState();
}

class _NDTabsState extends State<NDTabs> {
  @override
  Widget build(BuildContext context) => Container(
        child: DefaultTabController(
          initialIndex: widget.initialIndex!,
          length: widget.length,
          child: Container(
            height: widget.height ?? MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: <Widget>[
                NDTabBar(
                  isScrollable: widget.isScrollable,
                  shape: widget.shape,
                  length: widget.length,
                  tabBarHeight: widget.tabBarHeight,
                  tabBarColor: widget.tabBarColor ?? NDColors.PRIMARY,
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
                Expanded(child: widget.tabBarView),
              ],
            ),
          ),
        ),
      );
}
