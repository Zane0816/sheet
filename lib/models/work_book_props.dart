import 'package:sheet/models/defined_name.dart';
import 'package:sheet/models/sheet_props.dart';
import 'package:sheet/models/work_book_view.dart';
import 'package:sheet/models/work_book_properties.dart';

class WorkBookProps {
  /// Sheet Properties
  final List<SheetProps>? Sheets;

  /// Defined Names
  final List<DefinedName>? Names;

  /// Workbook Views
  final List<WorkBookView>? Views;

  /// Other Workbook Properties
  final WorkbookProperties? WBProps;

  const WorkBookProps({
    this.Sheets,
    this.Names,
    this.Views,
    this.WBProps,
  });
}
