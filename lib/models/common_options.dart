class CommonOptions {
  /// If true, throw errors when features are not understood
  /// @default false
  final bool? WTF;

  /// When reading a file with VBA macros, expose CFB blob to `vbaraw` field
  /// When writing BIFF8/XLSB/XLSM, reseat `vbaraw` and export to file
  /// @default false
  final bool? bookVBA;

  /// When reading a file, store dates as type d (default is n)
  /// When writing XLSX/XLSM file, use native date (default uses date codes)
  /// @default false
  final bool? cellDates;

  /// Create cell objects for stub cells
  /// @default false
  final bool? sheetStubs;

  /// When reading a file, save style/theme info to the .s field
  /// When writing a file, export style/theme info
  /// @default false
  final bool? cellStyles;

  /// If defined and file is encrypted, use password
  /// @default ''
  final String? password;

  const CommonOptions({
    this.WTF,
    this.bookVBA,
    this.cellDates,
    this.sheetStubs,
    this.cellStyles,
    this.password,
  });
}
