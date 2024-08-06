import 'package:sheet/models/dbf_field.dart';

class ColInfo {
  /* --- visibility --- */

  /// if true, the column is hidden
  final bool? hidden;

  /* --- column width --- */

  /// width in Excel's "Max Digit Width", width*256 is integral
  final num? width;

  /// width in screen pixels
  final num? wpx;

  /// width in "characters"
  final num? wch;

  /// outline / group level
  final num? level;

  /// Excel's "Max Digit Width" unit, always integral
  final num? MDW;

  /// DBF Field Header
  final DBFField? DBF;

  const ColInfo({
    this.hidden,
    this.width,
    this.wpx,
    this.wch,
    this.level,
    this.MDW,
    this.DBF,
  });
}
