import 'dart:io';
import 'dart:typed_data';

import 'package:sheet/cfb/cfb.dart';
import 'package:sheet/cfb/models/cfb_container.dart';
import 'package:sheet/dbf/dbf.dart';
import 'package:sheet/models/constant.dart';
import 'package:sheet/models/index.dart';
import 'package:sheet/models/parsing_options.dart';
import 'package:sheet/models/work_book.dart';

class SheetDart {
  int _current_codepage = 1200;
  int _current_ansi = 1252;

  /*global cptable:true, window */
  dynamic _cptable;

  // spreadsheet formatting options
  ParsingOptions _ssfopts = ParsingOptions();

  _set_ansi(int cp) {
    if (!Constant.VALID_ANSI.contains(cp)) return;
    _current_ansi = Constant.CS2CP[0] = cp;
  }

  _set_cp(int cp) {
    _current_codepage = cp;
    _set_ansi(cp);
  }

  _reset_ansi() {
    _set_ansi(1252);
  }

  _reset_cp() {
    _set_cp(1200);
    _reset_ansi();
  }

  _firstbyte(f, ParsingOptions o) {
    var x = "";
    switch (o.type ?? DataType.base64) {
      case DataType.buffer:
        return [f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7]];
      case DataType.base64:
        x = Base64_decode(f.slice(0, 12));
        break;
      case DataType.binary:
        x = f;
        break;
      case DataType.array:
        return [f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7]];
      default:
        throw Exception("Unrecognized type ${o.type?.name ?? "undefined"}");
    }
    return [
      x.charCodeAt(0),
      x.charCodeAt(1),
      x.charCodeAt(2),
      x.charCodeAt(3),
      x.charCodeAt(4),
      x.charCodeAt(5),
      x.charCodeAt(6),
      x.charCodeAt(7)
    ];
  }

  _read_cfb(CFBContainer cfb, ParseOpts opts) {
    if (CFB.find(cfb, "EncryptedPackage") != null) {
      return _parse_xlsxcfb(cfb, opts);
    }
    return _parse_xlscfb(cfb, opts);
  }

  _fix_opts_func(defaults) {
    return (opts) {
      for (var i = 0; i != defaults.length; ++i) {
        var d = defaults[i];
        if (opts[d[0]] == null) opts[d[0]] = d[1];
        if (d[2] == 'n') opts[d[0]] = num.tryParse(opts[d[0]]);
      }
    };
  }

  _fix_read_opts(opts) {
    _fix_opts_func([
      ['cellNF', false],
      /* emit cell number format string as .z */
      ['cellHTML', true],
      /* emit html string as .h */
      ['cellFormula', true],
      /* emit formulae as .f */
      ['cellStyles', false],
      /* emits style/theme as .s */
      ['cellText', true],
      /* emit formatted text as .w */
      ['cellDates', false],
      /* emit date cells with type `d` */

      ['sheetStubs', false],
      /* emit empty cells */
      ['sheetRows', 0, 'n'],
      /* read n rows (0 = read all rows) */

      ['bookDeps', false],
      /* parse calculation chains */
      ['bookSheets', false],
      /* only try to get sheet names (no Sheets) */
      ['bookProps', false],
      /* only try to get properties (no Sheets) */
      ['bookFiles', false],
      /* include raw file structure (keys, files, cfb) */
      ['bookVBA', false],
      /* include vba raw data (vbaraw) */

      ['password', ''],
      /* password */
      ['WTF', false] /* WTF mode (throws errors) */
    ])(opts);
  }

  _parse_xlscfb(cfb, ParseOpts? options) {
    if (!options) options = {};
    _fix_read_opts(options);
    _reset_cp();
    if (options.codepage) _set_ansi(options.codepage);
    var CompObj /*:?CFBEntry*/, WB /*:?any*/;
    if (cfb.FullPaths) {
      if (CFB.find(cfb, '/encryption') != null) {
        throw Exception("File is password-protected");
      }
      CompObj = CFB.find(cfb, '!CompObj');
      WB = CFB.find(cfb, '/Workbook') ?? CFB.find(cfb, '/Book');
    } else {
      switch (options.type) {
        case 'base64':
          cfb = s2a(Base64_decode(cfb));
          break;
        case 'binary':
          cfb = s2a(cfb);
          break;
        case 'buffer':
          break;
        case 'array':
          if (!Array.isArray(cfb)) cfb = Array.prototype.slice.call(cfb);
          break;
      }
      prep_blob(cfb, 0);
      WB = ({content: cfb} /*:any*/);
    }
    var /*::CompObjP, */ WorkbookP /*:: :Workbook = XLSX.utils.book_new(); */;

    var _data /*:?any*/;
    if (CompObj) /*::CompObjP = */ parse_compobj(CompObj);
    if (options.bookProps && !options.bookSheets) {
      WorkbookP = ({} /*:any*/);
    } else /*:: if(cfb instanceof CFBContainer) */ {
      var T = has_buf ? 'buffer' : 'array';
      if (WB && WB.content) {
        WorkbookP = parse_workbook(WB.content, options);
      } else if ((_data = CFB.find(cfb, 'PerfectOffice_MAIN')) && _data.content)
        WorkbookP = WK_.to_workbook(_data.content, (options.type = T, options));
      /* Quattro Pro 9 */
      else if ((_data = CFB.find(cfb, 'NativeContent_MAIN')) && _data.content)
        WorkbookP = WK_.to_workbook(_data.content, (options.type = T, options));
      /* Works 4 for Mac */
      else if ((_data = CFB.find(cfb, 'MN0')) && _data.content)
        throw Exception("Unsupported Works 4 for Mac file");
      else
        throw Exception("Cannot find Workbook stream");
      if (options.bookVBA &&
          cfb.FullPaths &&
          CFB.find(cfb, '/_VBA_PROJECT_CUR/VBA/dir')) {
        WorkbookP.vbaraw = make_vba_xls(cfb);
      }
    }

    var props = {};
    if (cfb.FullPaths) {
      parse_xls_props(
          /*::((*/
          cfb /*:: :any):CFBContainer)*/,
          props,
          options);
    }

    WorkbookP.Props =
        WorkbookP.Custprops = props; /* TODO: split up properties */
    if (options.bookFiles) WorkbookP.cfb = cfb;
/*WorkbookP.CompObjP = CompObjP; // TODO: storage? */
    return WorkbookP;
  }

  parse() {}

  parseZip() {}

  Future<WorkBook> read(Uint8List data, ParsingOptions? options) async {
    _reset_cp();
    final o = options ?? ParsingOptions();
    if (o.codepage != null && _cptable == null) {
      stderr.writeln(
          "Codepage tables are not loaded.  Non-ASCII characters may not give expected results");
    }
    var d = data, n = [0, 0, 0, 0], str = false;
    if (o.cellStyles != null) {
      o.cellNF = true;
      o.sheetStubs = true;
    }
    _ssfopts = ParsingOptions();
    if (o.dateNF?.isNotEmpty ?? false) _ssfopts.dateNF = o.dateNF;
    switch ((n = _firstbyte(d, o))[0]) {
      case 0xD0:
        if (n[1] == 0xCF &&
            n[2] == 0x11 &&
            n[3] == 0xE0 &&
            n[4] == 0xA1 &&
            n[5] == 0xB1 &&
            n[6] == 0x1A &&
            n[7] == 0xE1) return _read_cfb(CFB.read(d, o), o);
        break;
      case 0x09:
        if (n[1] <= 0x08) return _parse_xlscfb(d, o);
        break;
      case 0x3C:
        return parse_xlml(d, o);
      case 0x49:
        if (n[1] == 0x49 && n[2] == 0x2a && n[3] == 0x00) {
          throw Exception("TIFF Image File is not a spreadsheet");
        }
        if (n[1] == 0x44) return read_wb_ID(d, o);
        break;
      case 0x54:
        if (n[1] == 0x41 && n[2] == 0x42 && n[3] == 0x4C) {
          return DIF.to_workbook(d, o);
        }
        break;
      case 0x50:
        return (n[1] == 0x4B && n[2] < 0x09 && n[3] < 0x09)
            ? read_zip(d, o)
            : read_prn(data, d, o, str);
      case 0xEF:
        return n[3] == 0x3C ? parse_xlml(d, o) : read_prn(data, d, o, str);
      case 0xFF:
        if (n[1] == 0xFE) {
          return read_utf16(d, o);
        } else if (n[1] == 0x00 && n[2] == 0x02 && n[3] == 0x00)
          return WK_.to_workbook(d, o);
        break;
      case 0x00:
        if (n[1] == 0x00) {
          if (n[2] >= 0x02 && n[3] == 0x00) return WK_.to_workbook(d, o);
          if (n[2] == 0x00 && (n[3] == 0x08 || n[3] == 0x09)) {
            return WK_.to_workbook(d, o);
          }
        }
        break;
      case 0x03:
      case 0x83:
      case 0x8B:
      case 0x8C:
        return DBF.to_workbook(d, o);
      case 0x7B:
        if (n[1] == 0x5C && n[2] == 0x72 && n[3] == 0x74) {
          return rtf_to_workbook(d, o);
        }
        break;
      case 0x0A:
      case 0x0D:
      case 0x20:
        return read_plaintext_raw(d, o);
      case 0x89:
        if (n[1] == 0x50 && n[2] == 0x4E && n[3] == 0x47) {
          throw Exception("PNG Image File is not a spreadsheet");
        }
        break;
      case 0x08:
        if (n[1] == 0xE7) throw Exception("Unsupported Multiplan 1.x file!");
        break;
      case 0x0C:
        if (n[1] == 0xEC) throw Exception("Unsupported Multiplan 2.x file!");
        if (n[1] == 0xED) throw Exception("Unsupported Multiplan 3.x file!");
        break;
    }
    if (Constant.DBF_SUPPORTED_VERSIONS.contains(n[0]) && n[2] <= 12 && n[3] <= 31) {
      return DBF.to_workbook(d, o);
    }
    return read_prn(data, d, o, str);
  }

  readFile() {}

  write() {}

  writeFile() {}
}
