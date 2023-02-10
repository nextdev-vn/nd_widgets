import 'package:flutter/material.dart';

import '../../constants/colors/nd_color.dart';
import 'nd_intro_screen_bottom_navigation_bar.dart';

class NDIntroScreen extends StatefulWidget {
  const NDIntroScreen({
    Key? key,
    required this.pageController,
    required this.currentIndex,
    required this.pageCount,
    required this.slides,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.introScreenBottomNavigationBar,
    this.showIntroScreenBottomNavigationBar = true,
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
    this.inactiveColor = NDColors.LIGHT,
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

  final List<Widget> slides;

  final PageController pageController;

  final Color? color;

  final double? height;

  final double? width;

  final BorderRadius? borderRadius;

  final Border? border;

  final NDIntroScreenBottomNavigationBar? introScreenBottomNavigationBar;

  final bool showIntroScreenBottomNavigationBar;

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
  _NDIntroScreenState createState() => _NDIntroScreenState();
}

class _NDIntroScreenState extends State<NDIntroScreen> {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
            border: widget.border ?? Border.all(width: 0),
            color: widget.color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: widget.pageController,
                  children: widget.slides,
                ),
              ),
              widget.showIntroScreenBottomNavigationBar
                  ? widget.introScreenBottomNavigationBar ??
                      NDIntroScreenBottomNavigationBar(
                        pageController: widget.pageController,
                        pageCount: widget.slides.length,
                        currentIndex: widget.currentIndex,
                        child: widget.child,
                        navigationBarColor: widget.navigationBarColor,
                        navigationBarHeight: widget.navigationBarHeight,
                        navigationBarShape: widget.navigationBarShape,
                        navigationBarWidth: widget.navigationBarWidth,
                        navigationBarPadding: widget.navigationBarPadding,
                        navigationBarMargin: widget.navigationBarMargin,
                        showDivider: widget.showDivider,
                        dividerColor: widget.dividerColor,
                        dividerHeight: widget.dividerHeight,
                        dividerThickness: widget.dividerThickness,
                        dotShape: widget.dotShape,
                        inactiveColor: widget.inactiveColor,
                        activeColor: widget.activeColor,
                        dotHeight: widget.dotHeight,
                        dotWidth: widget.dotWidth,
                        dotMargin: widget.dotMargin,
                        backButton: widget.backButton,
                        forwardButton: widget.forwardButton,
                        doneButton: widget.doneButton,
                        skipButton: widget.skipButton,
                        onDoneTap: widget.onDoneTap,
                        onForwardButtonTap: widget.onForwardButtonTap,
                        onBackButtonTap: widget.onBackButtonTap,
                        onSkipTap: widget.onSkipTap,
                        forwardButtonText: widget.forwardButtonText,
                        backButtonText: widget.backButtonText,
                        doneButtonText: widget.doneButtonText,
                        skipButtonText: widget.skipButtonText,
                        skipButtonTextStyle: widget.skipButtonTextStyle,
                        doneButtonTextStyle: widget.doneButtonTextStyle,
                        backButtonTextStyle: widget.backButtonTextStyle,
                        forwardButtonTextStyle: widget.forwardButtonTextStyle,
                        showButton: widget.showButton,
                        showPagination: widget.showPagination,
                      )
                  : Container(),
            ],
          ),
        ),
      );
}
