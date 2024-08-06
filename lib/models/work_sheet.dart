import 'package:sheet/models/auto_filter_info.dart';
import 'package:sheet/models/col_info.dart';
import 'package:sheet/models/protect_info.dart';
import 'package:sheet/models/row_info.dart';
import 'package:sheet/models/sheet.dart';
import 'package:sheet/models/range.dart';

class WorkSheet extends Sheet {
  /**
   * Indexing with a cell address string maps to a cell object
   * Special keys start with '!'
   */
  // [cell: string]: CellObject | WSKeys | any;

  /// Column Info
  final List<ColInfo>? _cols;

  /// Row Info
  final List<RowInfo>? _rows;

  /// Merge Ranges
  final List<Range>? _merges;

  /// Worksheet Protection info
  final ProtectInfo? _protect;

  /// AutoFilter info
  final AutoFilterInfo? _autoFilter;

  const WorkSheet({
    super.data,
    super.type,
    super.ref,
    super.margins,
    List<ColInfo>? cols,
    List<RowInfo>? rows,
    List<Range>? merges,
    ProtectInfo? protect,
    AutoFilterInfo? autoFilter,
  })  : _cols = cols,
        _rows = rows,
        _merges = merges,
        _protect = protect,
        _autoFilter = autoFilter;
}
