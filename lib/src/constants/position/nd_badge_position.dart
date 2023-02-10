class NDBadgePosition {
  const NDBadgePosition({this.top, this.end, this.bottom, this.start});

  factory NDBadgePosition.topStart({double top = -5, double start = -10}) =>
      NDBadgePosition(top: top, start: start);

  factory NDBadgePosition.topEnd({double top = -8, double end = -10}) =>
      NDBadgePosition(top: top, end: end);

  factory NDBadgePosition.bottomEnd({double bottom = -8, double end = -10}) =>
      NDBadgePosition(bottom: bottom, end: end);

  factory NDBadgePosition.bottomStart(
          {double bottom = -8, double start = -10}) =>
      NDBadgePosition(bottom: bottom, start: start);

  final double? top;

  final double? end;

  final double? start;

  final double? bottom;
}
