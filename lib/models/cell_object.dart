import 'package:sheet/models/comments.dart';
import 'package:sheet/models/hyperlink.dart';
import 'package:sheet/models/index.dart';

class CellObject {
  /// The raw value of the cell.  Can be omitted if a formula is specified
  final dynamic v; //string | number | boolean | Date

  /// Formatted text (if applicable)
  final String? w;

  /// The Excel Data Type of the cell.
  /// b Boolean, n Number, e Error, s String, d Date, z Empty
  final ExcelDataType t;

  /// Cell formula (if applicable)
  final String? f;

  /// Range of enclosing array if formula is array formula (if applicable)
  final String? F;

  /// If true, cell is a dynamic array formula (for supported file formats)
  final bool? D;

  /// Rich text encoding (if applicable)
  final dynamic r;

  /// HTML rendering of the rich text (if applicable)
  final String? h;

  /// Comments associated with the cell
  final Comments? c;

  /// Number format string associated with the cell (if requested)
  final dynamic z; //string | number

  /// Cell hyperlink object (.Target holds link, .tooltip is tooltip)
  final Hyperlink? l;

  /// The style/theme of the cell (if applicable)
  final dynamic s;

  const CellObject({
    this.v,
    this.w,
    required this.t,
    this.f,
    this.F,
    this.D,
    this.r,
    this.h,
    this.c,
    this.z,
    this.l,
    this.s,
  });
}
