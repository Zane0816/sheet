class RowInfo {
  /* --- visibility --- */

  /// if true, the column is hidden
  final bool? hidden;

  /* --- row height --- */

  /// height in screen pixels
  final num? hpx;

  /// height in points
  final num? hpt;

  /// outline / group level
  final num? level;

  const RowInfo({
    this.hidden,
    this.hpx,
    this.hpt,
    this.level,
  });
}
