import 'package:sheet/models/work_book.dart';

class DBF {
  static dbf_to_sheet(buf, opts) {
    var o = opts || {};
    if (!o.dateNF) o.dateNF = "yyyymmdd";
    var ws = aoa_to_sheet(dbf_to_aoa(buf, o), o);
    ws["!cols"] = o.DBF.map(function(field) { return {
    wch: field.len,
    DBF: field
    };});
    delete o.DBF;
    return ws;
  }

  static WorkBook to_workbook(buf, opts) {
    try {
      var o = sheet_to_workbook(dbf_to_sheet(buf, opts), opts);
      o.bookType = "dbf";
      return o;
    } catch (e) {
      if (opts && opts.WTF) rethrow;
    }
    return const WorkBook(SheetNames: [], Sheets: {});
  }
}
