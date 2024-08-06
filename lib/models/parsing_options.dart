import 'package:sheet/models/common_options.dart';
import 'package:sheet/models/dense_option.dart';
import 'package:sheet/models/utc_option.dart';

class ParsingOptions implements UTCOption, CommonOptions, DenseOption {
  @override
  final bool? UTC;
  @override
  final bool? WTF;
  @override
  final bool? bookVBA;
  @override
  final bool? cellDates;
  @override
  bool? sheetStubs;
  @override
  final bool? cellStyles;
  @override
  final String? password;
  @override
  final bool? dense;

  /// Input data encoding
  // DataType? type;

  /// Default codepage for legacy files
  ///
  /// This requires encoding support to be loaded.  It is automatically loaded
  /// in `xlsx.full.min.js` and in CommonJS / Extendscript, but an extra step
  /// is required in React / Angular / Webpack ESM deployments.
  ///
  /// Check the relevant guide https://docs.sheetjs.com/docs/getting-started/
  num? codepage;

  /// Save formulae to the .f field
  /// @default true
  final bool? cellFormula;

  /// Parse rich text and save HTML to the .h field
  /// @default true
  final bool? cellHTML;

  /// Save number format string to the .z field
  /// @default false
  bool? cellNF;

  /// Generate formatted text to the .w field
  /// @default true
  final bool? cellText;

  /// Override default date format (code 14)
  String? dateNF;

  /// Field Separator ("Delimiter" override)
  final String? FS;

  /// If >0, read the first sheetRows rows
  /// @default 0
  final num? sheetRows;

  /// If true, parse calculation chains
  /// @default false
  final bool? bookDeps;

  /// If true, add raw files to book object
  /// @default false
  final bool? bookFiles;

  /// If true, only parse enough to get book metadata
  /// @default false
  final bool? bookProps;

  /// If true, only parse enough to get the sheet names
  /// @default false
  final bool? bookSheets;

  /// If specified, only parse the specified sheets or sheet names
  final dynamic sheets; //number | string | Array<number | string>;

  /// If true, plaintext parsing will not parse values
  final bool? raw;

  /// If true, ignore "dimensions" records and guess range using every cell
  final bool? nodim;

  /// If true, preserve _xlfn. prefixes in formula function names
  final bool? xlfn;

  /// For single-sheet formats (including CSV), override the worksheet name
  /// @default "Sheet1"
  final String? sheet;

  final bool? PRN;

  ParsingOptions({
    this.UTC,
    this.WTF,
    this.bookVBA,
    this.cellDates,
    this.sheetStubs,
    this.cellStyles,
    this.password,
    this.dense,
    // this.type,
    this.codepage,
    this.cellFormula,
    this.cellHTML,
    this.cellNF,
    this.cellText,
    this.dateNF,
    this.FS,
    this.sheetRows,
    this.bookDeps,
    this.bookFiles,
    this.bookProps,
    this.bookSheets,
    this.sheets,
    this.raw,
    this.nodim,
    this.xlfn,
    this.sheet,
    this.PRN,
  });
}
