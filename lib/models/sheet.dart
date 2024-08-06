import 'dart:collection';

import 'cell_object.dart';
import 'index.dart';
import 'margin_info.dart';

class Sheet extends MapBase<String, dynamic> {
  /**
   * Sparse-mode store cells with keys corresponding to A1-style address
   * Dense-mode  store cells in the '!data' key
   * Special keys start with '!'
   */
  // [cell: string]: CellObject | CellObject[][] | SheetKeys | any;

  /// Dense-mode worksheets store data in an array of arrays
  ///
  /// Cells are accessed with sheet['!data'][R][C] (where R and C are 0-indexed)
  final List<List<CellObject>>? _data;

  /// Sheet type
  final SheetType? _type;

  /// Sheet Range (A1-style)
  final String? _ref;

  /// Page Margins
  final MarginInfo? _margins;

  const Sheet({
    List<List<CellObject>>? data,
    SheetType? type,
    String? ref,
    MarginInfo? margins,
  })  : _data = data,
        _type = type,
        _ref = ref,
        _margins = margins;

  @override
  operator [](Object? key) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void operator []=(String key, value) {
    // TODO: implement []=
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  // TODO: implement keys
  Iterable<String> get keys => throw UnimplementedError();

  @override
  remove(Object? key) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
