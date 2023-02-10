import 'dart:math' show min, max;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../constants/position/nd_position.dart';

typedef RenderNDStickyHeaderCallback = void Function(double stuckValue);

class RenderNDStickyHeader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, FlexParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, FlexParentData>,
        DebugOverflowIndicatorMixin {
  RenderNDStickyHeader({
    List<RenderBox>? children,
    Axis direction = Axis.horizontal,
    bool enableHeaderOverlap = false,
    required ScrollableState scrollable,
    RenderNDStickyHeaderCallback? callback,
    NDPosition? stickyContentPosition,
  })  : _scrollable = scrollable,
        _direction = direction,
        _callback = callback,
        _stickyContentPosition = stickyContentPosition,
        _enableHeaderOverlap = enableHeaderOverlap {
    addAll(children);
  }

  RenderNDStickyHeaderCallback? _callback;
  final ScrollableState _scrollable;
  final bool _enableHeaderOverlap;
  final NDPosition? _stickyContentPosition;

  Axis get direction => _direction;
  Axis _direction;
  set direction(Axis value) {
    if (_direction != value) {
      _direction = value;
      markNeedsLayout();
    }
  }

  set callback(RenderNDStickyHeaderCallback value) {
    if (_callback == value) {
      return;
    }
    _callback = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! FlexParentData) {
      child.parentData = FlexParentData();
    }
  }

  int _getFlex(RenderBox child) {
    final FlexParentData childParentData = child.parentData as FlexParentData;
    return childParentData.flex ?? 0;
  }

  double _getCrossSize(RenderBox child) {
    switch (_direction) {
      case Axis.horizontal:
        return child.size.height;
      case Axis.vertical:
        return child.size.width;
    }
  }

  double _getMainSize(RenderBox child) {
    switch (_direction) {
      case Axis.horizontal:
        return child.size.width;
      case Axis.vertical:
        return child.size.height;
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  RenderBox? get _stickyContentBody => _stickyContentPosition ==
              NDPosition.start &&
          _direction == Axis.horizontal
      ? firstChild
      : _stickyContentPosition == NDPosition.end && _direction == Axis.vertical
          ? firstChild
          : lastChild;
  RenderBox? get _contentBody => _stickyContentPosition == NDPosition.start &&
          _direction == Axis.horizontal
      ? lastChild
      : _stickyContentPosition == NDPosition.end && _direction == Axis.vertical
          ? lastChild
          : firstChild;

  double getHeaderTileStuckOffset() {
    final scrollableContent = _scrollable.context.findRenderObject()!;
    if (scrollableContent.attached) {
      try {
        return localToGlobal(Offset.zero, ancestor: scrollableContent).dy;
      } catch (e) {
        print(e);
      }
    }
    return 0;
  }

  @override
  void performLayout() {
    assert(childCount == 2);
    _stickyContentBody?.layout(constraints.loosen(), parentUsesSize: true);
    _contentBody?.layout(constraints.loosen(), parentUsesSize: true);
    final stickyContentBodyHeight = _stickyContentBody!.size.height;
    final contentBodyHeight = _contentBody!.size.height;
    final height = max(
        constraints.minHeight,
        _enableHeaderOverlap
            ? contentBodyHeight
            : stickyContentBodyHeight + contentBodyHeight);
    final width = max(constraints.minWidth, contentBodyHeight);

    size = Size(
        constraints.constrainWidth(width), constraints.constrainHeight(height));
    final double stickyContentBodyOffset = getHeaderTileStuckOffset();

    double crossSize = 0;
    double allottedSize = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final FlexParentData? childParentData =
          child.parentData as FlexParentData?;
      final int flex = _getFlex(child);
      if (flex > 0) {
      } else {
        late BoxConstraints innerConstraints;
        switch (_direction) {
          case Axis.horizontal:
            innerConstraints = BoxConstraints(maxHeight: constraints.maxHeight);
            break;
          case Axis.vertical:
            innerConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
            break;
        }
        child.layout(innerConstraints, parentUsesSize: true);
        allottedSize += _getMainSize(child);
        crossSize = math.max(crossSize, _getCrossSize(child));
      }
      assert(child.parentData == childParentData);
      child = childParentData?.nextSibling;
    }

    final double idealSize = allottedSize;
    late double actualSize;
    switch (_direction) {
      case Axis.horizontal:
        size = constraints.constrain(Size(idealSize, crossSize));
        actualSize = size.width;
        crossSize = size.height;
        break;
      case Axis.vertical:
        size = constraints.constrain(Size(crossSize, idealSize));
        actualSize = size.height;
        crossSize = size.width;
        break;
    }
    const double startingSpace = 0;
    const double betweenSpace = 0;
    const bool flipMainAxis = !true;
    double childMainPosition =
        flipMainAxis ? actualSize - startingSpace : startingSpace;
    child = _contentBody;

    while (child != null) {
      final FlexParentData? childParentData =
          child.parentData as FlexParentData?;

      switch (_direction) {
        case Axis.horizontal:
          final FlexParentData contentBodyParentData =
              _contentBody!.parentData as FlexParentData;
          contentBodyParentData.offset =
              _stickyContentPosition == NDPosition.start
                  ? Offset(_stickyContentBody!.size.width, 0)
                  : const Offset(0, 0);
          final FlexParentData stickyContentBodyParentData =
              _stickyContentBody!.parentData as FlexParentData;
          stickyContentBodyParentData.offset = Offset(
              childMainPosition,
              max(
                  min(-stickyContentBodyOffset,
                      height - stickyContentBodyHeight),
                  0));
          break;
        case Axis.vertical:
          final FlexParentData contentBodyParentData =
              _contentBody!.parentData as FlexParentData;
          contentBodyParentData.offset =
              Offset(0, _enableHeaderOverlap ? 0.0 : stickyContentBodyHeight);
          final FlexParentData stickyContentBodyParentData =
              _stickyContentBody!.parentData as FlexParentData;
          stickyContentBodyParentData.offset = Offset(
              0,
              max(
                  0,
                  min(-stickyContentBodyOffset,
                      height - stickyContentBodyHeight)));
          break;
      }
      if (_callback != null) {
        final stuckValue = max(
                min(stickyContentBodyHeight, stickyContentBodyOffset),
                -stickyContentBodyHeight) /
            stickyContentBodyHeight;
        _callback!(stuckValue);
      }

      if (!flipMainAxis) {
        childMainPosition += _getMainSize(child) + betweenSpace;
      }
      child = childParentData!.nextSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
