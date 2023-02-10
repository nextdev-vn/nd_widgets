import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../constants/types/nd_button_type.dart';
import '../button/nd_icon_button.dart';

class NDAppBar extends StatefulWidget implements PreferredSizeWidget {
  NDAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.searchBar = false,
    this.searchHintText = 'Search...',
    this.searchHintStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    this.searchTextStyle = const TextStyle(
      color: Colors.white,
    ),
    this.searchBarColorTheme = Colors.white,
    this.searchController,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0),
        ),
        super(key: key);

  final Widget? leading;

  final bool automaticallyImplyLeading;

  final Widget? title;

  final List<Widget>? actions;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final Brightness? brightness;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final TextTheme? textTheme;

  final bool primary;

  final bool? centerTitle;

  final double titleSpacing;

  final double toolbarOpacity;

  final double bottomOpacity;

  @override
  final Size preferredSize;

  final bool searchBar;

  final String searchHintText;

  final TextStyle searchHintStyle;

  final TextStyle searchTextStyle;

  final Color searchBarColorTheme;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final TextEditingController? searchController;

  final GestureTapCallback? onTap;

  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (centerTitle != null) {
      return centerTitle!;
    }
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
        return actions == null || actions!.length < 2;
      default:
        return false;
    }
  }

  @override
  _NDAppBarState createState() => _NDAppBarState();
}

class _NDAppBarState extends State<NDAppBar> {
  static const double _defaultElevation = 4;
  Widget? searchBar;
  bool showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool hasDrawer = scaffold.hasDrawer;
    final bool hasEndDrawer = scaffold.hasEndDrawer;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData overallIconTheme =
        widget.iconTheme ?? appBarTheme.iconTheme ?? theme.primaryIconTheme;
    IconThemeData actionsIconTheme = widget.actionsIconTheme ??
        appBarTheme.actionsIconTheme ??
        overallIconTheme;
    TextStyle? centerStyle = widget.textTheme?.headline5 ??
        appBarTheme.titleTextStyle ??
        theme.primaryTextTheme.headline5;
    TextStyle? sideStyle = widget.textTheme?.bodyText1 ??
        appBarTheme.toolbarTextStyle ??
        theme.primaryTextTheme.bodyText1;

    if (widget.toolbarOpacity != 1.0) {
      final double opacity = const Interval(
        0.25,
        1,
        curve: Curves.fastOutSlowIn,
      ).transform(widget.toolbarOpacity);
      if (centerStyle?.color != null) {
        centerStyle = centerStyle!.copyWith(
          color: centerStyle.color!.withOpacity(opacity),
        );
      }
      if (sideStyle?.color != null) {
        sideStyle = sideStyle!.copyWith(
          color: sideStyle.color!.withOpacity(opacity),
        );
      }
      overallIconTheme = overallIconTheme.copyWith(
        opacity: opacity * (overallIconTheme.opacity ?? 1.0),
      );
      actionsIconTheme = actionsIconTheme.copyWith(
        opacity: opacity * (actionsIconTheme.opacity ?? 1.0),
      );
    }

    Widget? leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop) {
          leading = useCloseButton ? const CloseButton() : const BackButton();
        }
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
        child: leading,
      );
    }

    Widget? title = widget.title;
    if (title != null && centerStyle != null) {
      bool? namesRoute;
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
          break;
        default:
          break;
      }
      title = DefaultTextStyle(
        style: centerStyle,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute,
          child: NDAppBarTitleBar(child: title),
          header: true,
        ),
      );
    }

    Widget? actions;
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions!,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    if (actions != null) {
      actions = IconTheme.merge(
        data: actionsIconTheme,
        child: actions,
      );
    }

    if (showSearchBar) {
      searchBar = TextField(
        cursorColor: widget.searchBarColorTheme,
        style: widget.searchTextStyle,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: widget.searchBarColorTheme,
            size: 18,
          ),
          suffixIcon: NDIconButton(
            icon: Icon(
              Icons.close,
              color: widget.searchBarColorTheme,
              size: 20,
            ),
            type: NDButtonType.transparent,
            onPressed: () {
              widget.onSubmitted?.call('');
              final controller = widget.searchController ?? _searchController;
              setState(() {
                showSearchBar = !showSearchBar;
                controller.text = '';
              });
            },
          ),
          hintText: widget.searchHintText,
          hintStyle: widget.searchHintStyle,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.searchBarColorTheme,
            ),
          ),
        ),
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        controller: widget.searchController ?? _searchController,
        onSubmitted: widget.onSubmitted,
      );
    }

    if (!showSearchBar) {
      searchBar = ListTile(
        contentPadding: EdgeInsets.zero,
        title: title,
        trailing: NDIconButton(
          icon: Icon(
            Icons.search,
            color: widget.searchBarColorTheme,
            size: 20,
          ),
          type: NDButtonType.transparent,
          onPressed: () {
            setState(() {
              showSearchBar = true;
            });
          },
        ),
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: widget.searchBar ? searchBar : title,
      trailing: actions,
      centerMiddle: widget._getEffectiveCenterTitle(theme),
      middleSpacing: widget.titleSpacing,
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: const _ToolbarContainerLayout(),
        child: IconTheme.merge(
          data: overallIconTheme,
          child: DefaultTextStyle(
            style: sideStyle ?? const TextStyle(),
            child: toolbar,
          ),
        ),
      ),
    );
    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: kToolbarHeight),
              child: appBar,
            ),
          ),
          Opacity(
            opacity: const Interval(
              0.25,
              1,
              curve: Curves.fastOutSlowIn,
            ).transform(widget.bottomOpacity),
            child: widget.bottom,
          ),
        ],
      );
    }

    if (widget.primary) {
      appBar = SafeArea(
        top: true,
        child: appBar,
      );
    }

    appBar = Align(
      alignment: Alignment.topCenter,
      child: appBar,
    );

    if (widget.flexibleSpace != null) {
      appBar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          widget.flexibleSpace!,
          appBar,
        ],
      );
    }

    final Brightness brightness = widget.brightness ?? theme.brightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: widget.backgroundColor ??
              appBarTheme.backgroundColor ??
              theme.primaryColor,
          elevation:
              widget.elevation ?? appBarTheme.elevation ?? _defaultElevation,
          shape: widget.shape,
          child: Semantics(
            explicitChildNodes: true,
            child: appBar,
          ),
        ),
      ),
    );
  }
}

const double _kLeadingWidth = kToolbarHeight;

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.tighten(
        height: kToolbarHeight,
      );

  @override
  Size getSize(BoxConstraints constraints) => Size(
        constraints.maxWidth,
        kToolbarHeight,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset(0, size.height - childSize.height);

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}

class NDAppBarTitleBar extends SingleChildRenderObjectWidget {
  const NDAppBarTitleBar({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  RenderNDAppBarTitleBar createRenderObject(BuildContext context) =>
      RenderNDAppBarTitleBar(
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(
      BuildContext context, RenderNDAppBarTitleBar renderObject) {
    renderObject.textDirection = Directionality.of(context);
  }
}

class RenderNDAppBarTitleBar extends RenderAligningShiftedBox {
  RenderNDAppBarTitleBar({
    RenderBox? child,
    TextDirection? textDirection,
  }) : super(
          child: child,
          alignment: Alignment.center,
          textDirection: textDirection,
        );

  @override
  void performLayout() {
    final BoxConstraints innerConstraints =
        constraints.copyWith(maxHeight: double.infinity);
    child?.layout(
      innerConstraints,
      parentUsesSize: true,
    );
    if (child != null) {
      size = constraints.constrain(child!.size);
    }
    alignChild();
  }
}
