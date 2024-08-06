class ProtectInfo {
  /// The password for formats that support password-protected sheets
  /// (XLSX/XLSB/XLS). The writer uses the XOR obfuscation method.
  final String? password;

  /// Select locked cells
  /// @default: true
  final bool? selectLockedCells;

  /// Select unlocked cells
  /// @default: true
  final bool? selectUnlockedCells;

  /// Format cells
  /// @default: false
  final bool? formatCells;

  /// Format columns
  /// @default: false
  final bool? formatColumns;

  /// Format rows
  /// @default: false
  final bool? formatRows;

  /// Insert columns
  /// @default: false
  final bool? insertColumns;

  /// Insert rows
  /// @default: false
  final bool? insertRows;

  /// Insert hyperlinks
  /// @default: false
  final bool? insertHyperlinks;

  /// Delete columns
  /// @default: false
  final bool? deleteColumns;

  /// Delete rows
  /// @default: false
  final bool? deleteRows;

  /// Sort
  /// @default: false
  final bool? sort;

  /// Filter
  /// @default: false
  final bool? autoFilter;

  /// Use PivotTable reports
  /// @default: false
  final bool? pivotTables;

  /// Edit objects
  /// @default: true
  final bool? objects;

  /// Edit scenarios
  /// @default: true
  final bool? scenarios;

  const ProtectInfo({
    this.password,
    this.selectLockedCells,
    this.selectUnlockedCells,
    this.formatCells,
    this.formatColumns,
    this.formatRows,
    this.insertColumns,
    this.insertRows,
    this.insertHyperlinks,
    this.deleteColumns,
    this.deleteRows,
    this.sort,
    this.autoFilter,
    this.pivotTables,
    this.objects,
    this.scenarios,
  });
}
