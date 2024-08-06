/// Type of generated workbook
/// @default 'xlsx'
enum BookType {
  xlsx,
  xlsm,
  xlsb,
  xls,
  xla,
  biff8,
  biff5,
  biff2,
  xlml,
  ods,
  fods,
  csv,
  txt,
  sylk,
  slk,
  html,
  dif,
  rtf,
  prn,
  eth,
  dbf,
  numbers
}

/// Assuming the values are 0, 1, or 2 for Visible, Hidden, and VeryHidden respectively.
enum SheetVisibility { visible, hidden, veryHidden }

enum SheetType { sheet, chart }

/// The Excel data type for a cell.
/// b Boolean, n Number, e error, s String, d Date, z Stub
enum ExcelDataType { b, n, e, s, d, z }

enum DataType{
  base64 , binary , buffer , file , array , string
}