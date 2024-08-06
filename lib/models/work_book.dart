import 'package:sheet/models/full_properties.dart';
import 'index.dart';
import 'package:sheet/models/work_book_props.dart';
import 'package:sheet/models/work_sheet.dart';

class WorkBook {
  /// A dictionary of the worksheets in the workbook.
  /// Use SheetNames to reference these.
  final Map<String, WorkSheet> Sheets;

  /// Ordered list of the sheet names in the workbook
  final List<String> SheetNames;

  /// Standard workbook Properties
  final FullProperties? Props;

  /// Custom workbook Properties
  final dynamic object;

  final WorkBookProps? Workbook;

  final dynamic vbaraw;

  /// Original file type (when parsed with `read` or `readFile`)
  final BookType? bookType;

  const WorkBook({
    required this.Sheets,
    required this.SheetNames,
    this.Props,
    this.object,
    this.Workbook,
    this.vbaraw,
    this.bookType,
  });
}
