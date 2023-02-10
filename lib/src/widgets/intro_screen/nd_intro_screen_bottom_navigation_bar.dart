import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';

class NDIntroScreenBottomNavigationBar extends StatefulWidget {
  const NDIntroScreenBottomNavigationBar({
    Key? key,
    required this.pageController,
    required this.currentIndex,
    required this.pageCount,
    this.child,
    this.navigationBarColor = NDColors.SUCCESS,
    this.navigationBarHeight = 50,
    this.navigationBarShape,
    this.navigationBarWidth,
    this.navigationBarPadding = const EdgeInsets.all(8),
    this.navigationBarMargin = const EdgeInsets.all(8),
    this.showDivider = true,
    this.dividerColor = Colors.white,
    this.dividerHeight = 1,
    this.dividerThickness = 2,
    this.dotShape,
    this.inactiveColor = NDColors.DANGER,
    this.activeColor = NDColors.PRIMARY,
    this.dotHeight = 12,
    this.dotWidth = 12,
    this.dotMargin = const EdgeInsets.symmetric(horizontal: 2),
    this.backButton,
    this.forwardButton,
    this.doneButton,
    this.skipButton,
    this.onDoneTap,
    this.onForwardButtonTap,
    this.onBackButtonTap,
    this.onSkipTap,
    this.forwardButtonText = 'NEXT',
    this.backButtonText = 'BACK',
    this.doneButtonText = 'GO',
    this.skipButtonText = 'SKIP',
    this.skipButtonTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    this.doneButtonTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    this.backButtonTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    this.forwardButtonTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    this.showButton = true,
    this.showPagination = true,
  }) : super(key: key);

  final PageController pageController;

  final int currentIndex;

  final int pageCount;

  final Widget? child;

  final double navigationBarHeight;

  final double? navigationBarWidth;

  final EdgeInsets navigationBarPadding;

  final EdgeInsets navigationBarMargin;

  final Color navigationBarColor;

  final ShapeBorder? navigationBarShape;

  final VoidCallback? onForwardButtonTap;

  final VoidCallback? onBackButtonTap;

  final VoidCallback? onDoneTap;

  final VoidCallback? onSkipTap;

  final Widget? backButton;

  final Widget? forwardButton;

  final Widget? doneButton;

  final Widget? skipButton;

  final String backButtonText;

  final String forwardButtonText;

  final String doneButtonText;

  final String skipButtonText;

  final TextStyle skipButtonTextStyle;

  final TextStyle doneButtonTextStyle;

  final TextStyle backButtonTextStyle;

  final TextStyle forwardButtonTextStyle;

  final bool showDivider;

  final bool showButton;

  final bool showPagination;

  final double dividerHeight;

  final double dividerThickness;

  final Color dividerColor;

  final ShapeBorder? dotShape;

  final Color inactiveColor;

  final Color activeColor;

  final double dotHeight;

  final double dotWidth;

  final EdgeInsets dotMargin;

  @override
  _NDIntroScreenBottomNavigationBarState createState() =>
      _NDIntroScreenBottomNavigationBarState();
}

class _NDIntroScreenBottomNavigationBarState
    extends State<NDIntroScreenBottomNavigationBar> {
  late PageController _pageController;
  late int currentIndex;
  List<Widget>? pages;

  @override
  void initState() {
    _pageController = widget.pageController;
    currentIndex = _pageController.initialPage;
    _pageController = widget.pageController;
    _pageController.addListener(() {
      if (mounted) {
        final index = _pageController.page?.round();
        if (index != null) {
          setState(() {
            currentIndex = index;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onForwardButton() {
    widget.pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  void onBackButton() {
    widget.pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          widget.showDivider
              ? Divider(
                  height: widget.dividerHeight,
                  thickness: widget.dividerThickness,
                  color: widget.dividerColor,
                )
              : Container(),
          Container(
            height: widget.navigationBarHeight,
            width: widget.navigationBarWidth,
            child: Material(
              shape: widget.navigationBarShape,
              color: widget.navigationBarColor,
              child: Container(
                padding: widget.navigationBarPadding,
                margin: widget.navigationBarMargin,
                child: widget.child != null
                    ? Row(
                        children: [widget.child!],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.showButton
                              ? InkWell(
                                  child: currentIndex == 0
                                      ? widget.skipButton ??
                                          Text(widget.skipButtonText,
                                              style: widget.skipButtonTextStyle)
                                      : widget.backButton ??
                                          Text(widget.backButtonText,
                                              style:
                                                  widget.backButtonTextStyle),
                                  onTap: currentIndex == 0
                                      ? widget.onSkipTap
                                      : widget.onBackButtonTap ?? onBackButton,
                                )
                              : Container(),
                          widget.showPagination
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: getDotsList(),
                                )
                              : Container(),
                          widget.showButton
                              ? InkWell(
                                  child: currentIndex == widget.pageCount - 1
                                      ? widget.doneButton ??
                                          Text(widget.doneButtonText,
                                              style: widget.doneButtonTextStyle)
                                      : widget.forwardButton ??
                                          Text(widget.forwardButtonText,
                                              style: widget
                                                  .forwardButtonTextStyle),
                                  onTap: currentIndex == widget.pageCount - 1
                                      ? widget.onDoneTap
                                      : widget.onForwardButtonTap ??
                                          onForwardButton,
                                )
                              : Container(),
                        ],
                      ),
              ),
            ),
          )
        ],
      );

  List<Widget> getDotsList() {
    final List<Widget> list = [];
    for (int i = 0; i < widget.pageCount; i++) {
      list.add(Container(
        margin: widget.dotMargin,
        child: Material(
          shape: widget.dotShape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: currentIndex == i ? widget.activeColor : widget.inactiveColor,
          child: Container(
            width: widget.dotWidth,
            height: widget.dotHeight,
          ),
        ),
      ));
    }
    return list;
  }
}
