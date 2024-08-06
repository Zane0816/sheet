import 'package:sheet/models/cell_address.dart';

class Range {
  /// Starting cell
  final CellAddress s;

  /// Ending cell
  final CellAddress e;

  const Range({
    required this.s,
    required this.e,
  });
}
