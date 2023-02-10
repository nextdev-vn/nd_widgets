import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDAccordion extends StatefulWidget {
  const NDAccordion(
      {Key? key,
      this.title,
      this.content,
      this.titleChild,
      this.contentChild,
      this.collapsedTitleBackgroundColor = NDColors.WHITE,
      this.expandedTitleBackgroundColor = const Color(0xFFE0E0E0),
      this.collapsedIcon = const Icon(Icons.keyboard_arrow_down),
      this.expandedIcon = const Icon(Icons.keyboard_arrow_up),
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
      this.titlePadding = const EdgeInsets.all(10),
      this.contentBackgroundColor,
      this.contentPadding = const EdgeInsets.all(10),
      this.titleBorder = const Border(),
      this.contentBorder = const Border(),
      this.margin,
      this.showAccordion = false,
      this.onToggleCollapsed,
      this.titleBorderRadius = const BorderRadius.all(Radius.circular(0)),
      this.contentBorderRadius = const BorderRadius.all(Radius.circular(0))})
      : super(key: key);

  final bool showAccordion;

  final Widget? titleChild;

  final String? content;

  final Widget? contentChild;

  final Color collapsedTitleBackgroundColor;

  final Color expandedTitleBackgroundColor;

  final Widget collapsedIcon;

  final Widget expandedIcon;

  final String? title;

  final TextStyle textStyle;

  final EdgeInsets titlePadding;

  final EdgeInsets contentPadding;

  final Color? contentBackgroundColor;

  final EdgeInsets? margin;

  final Border titleBorder;

  final Border contentBorder;

  final BorderRadius titleBorderRadius;

  final BorderRadius contentBorderRadius;

  final Function(bool)? onToggleCollapsed;

  @override
  _NDAccordionState createState() => _NDAccordionState();
}

class _NDAccordionState extends State<NDAccordion>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController controller;
  late Animation<Offset> offset;
  late bool showAccordion;

  @override
  void initState() {
    showAccordion = widget.showAccordion;
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    offset = Tween(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: widget.margin ?? const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: _toggleCollapsed,
              borderRadius: widget.titleBorderRadius,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.titleBorderRadius,
                  border: widget.titleBorder,
                  color: showAccordion
                      ? widget.expandedTitleBackgroundColor
                      : widget.collapsedTitleBackgroundColor,
                ),
                padding: widget.titlePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: widget.title != null
                          ? Text(widget.title!, style: widget.textStyle)
                          : (widget.titleChild ?? Container()),
                    ),
                    showAccordion ? widget.expandedIcon : widget.collapsedIcon
                  ],
                ),
              ),
            ),
            showAccordion
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: widget.contentBorderRadius,
                      border: widget.contentBorder,
                      color: widget.contentBackgroundColor ?? Colors.white70,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: widget.contentPadding,
                    child: SlideTransition(
                      position: offset,
                      child: widget.content != null
                          ? Text(widget.content!)
                          : (widget.contentChild ?? Container()),
                    ))
                : Container()
          ],
        ),
      );

  void _toggleCollapsed() {
    setState(() {
      switch (controller.status) {
        case AnimationStatus.completed:
          controller.forward(from: 0);
          break;
        case AnimationStatus.dismissed:
          controller.forward();
          break;
        default:
      }
      showAccordion = !showAccordion;
      if (widget.onToggleCollapsed != null) {
        widget.onToggleCollapsed!(showAccordion);
      }
    });
  }
}
