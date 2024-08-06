class MarginInfo {
  /// Left side margin (inches)
  final num? left;

  /// Right side margin (inches)
  final num? right;

  /// Top side margin (inches)
  final num? top;

  /// Bottom side margin (inches)
  final num? bottom;

  /// Header top margin (inches)
  final num? header;

  /// Footer bottom height (inches)
  final num? footer;

  const MarginInfo({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.header,
    this.footer,
  });
}
