import 'dart:typed_data';

import 'package:sheet/cfb/models/cfb_container.dart';
import 'package:sheet/cfb/models/cfb_entry.dart';
import 'package:sheet/cfb/models/cfb_read_opts.dart';
import 'package:sheet/models/constant.dart';

class CFB {
  static CFBEntry? find(CFBContainer cfb, String path) {
    final UCFullPaths = cfb.FullPaths.map((x) => x.toUpperCase()).toList();
    final UCPaths = UCFullPaths.map((x) {
      var y = x.split("/");
      return y[y.length - (x.substring(-1) == "/" ? 2 : 1)];
    }).toList();
    var k = false;
    if (path.codeUnitAt(0) == 47) {
      k = true;
      path = UCFullPaths[0].substring(0, -1) + path;
    } else {
      k = path.contains("/");
    }
    var UCPath = path.toUpperCase();
    var w = k == true ? UCFullPaths.indexOf(UCPath) : UCPaths.indexOf(UCPath);
    if (w != -1) return cfb.FileIndex[w];

    var m = !Constant.chr1.hasMatch(UCPath);
    UCPath = UCPath.replaceAll(Constant.chr0, '');
    if (m) UCPath = UCPath.replaceAll(Constant.chr1, '!');
    for (w = 0; w < UCFullPaths.length; ++w) {
      if ((m ? UCFullPaths[w].replaceAll(Constant.chr1, '!') : UCFullPaths[w])
              .replaceAll(Constant.chr0, '') ==
          UCPath) return cfb.FileIndex[w];
      if ((m ? UCPaths[w].replaceAll(Constant.chr1, '!') : UCPaths[w])
              .replaceAll(Constant.chr0, '') ==
          UCPath) return cfb.FileIndex[w];
    }
    return null;
  }

  static read(Uint8List blob, CFBReadOpts? options) {
    return parse(blob, options);
  }

  static CFBContainer? parse(Uint8List file, CFBReadOpts? options) {
    if (file[0] == 0x50 && file[1] == 0x4b) return parse_zip(file, options);
    if ((file[0] | 0x20) == 0x6d && (file[1] | 0x20) == 0x69) {
      return parse_mad(file, options);
    }
    if (file.length < 512) {
      throw Exception("${"CFB file size ${file.length}"} < 512");
    }
    var mver = 3;
    var ssz = 512;
    var nmfs = 0; // number of mini FAT sectors
    var difat_sec_cnt = 0;
    var dir_start = 0;
    var minifat_start = 0;
    var difat_start = 0;

    var fat_addrs /*:Array<number>*/ = []; // locations of FAT sectors

/* [MS-CFB] 2.2 Compound File Header */
    var blob /*:CFBlob*/ = /*::(*/ file.sublist(0, 512) /*:: :any)*/;
    prep_blob(blob, 0);

/* major version */
    var mv = check_get_mver(blob);
    mver = mv[0];
    switch (mver) {
      case 3:
        ssz = 512;
        break;
      case 4:
        ssz = 4096;
        break;
      case 0:
        if (mv[1] == 0) return parse_zip(file, options);
      /* falls through */
      default:
        throw Exception("Major Version: Expected 3 or 4 saw " + mver);
    }

/* reprocess header */
    if (ssz != 512) {
      blob = /*::(*/ file.slice(0, ssz) /*:: :any)*/;
      prep_blob(blob, 28 /* blob.l */);
    }
/* Save header for final object */
    var header /*:RawBytes*/ = file.slice(0, ssz);

    check_shifts(blob, mver);

// Number of Directory Sectors
    var dir_cnt /*:number*/ = blob.read_shift(4, 'i');
    if (mver == 3 && dir_cnt != 0) {
      throw Exception('# Directory Sectors: Expected 0 saw ' + dir_cnt);
    }

// Number of FAT Sectors
    blob.l += 4;

// First Directory Sector Location
    dir_start = blob.read_shift(4, 'i');

// Transaction Signature
    blob.l += 4;

// Mini Stream Cutoff Size
    blob.chk('00100000', 'Mini Stream Cutoff Size: ');

// First Mini FAT Sector Location
    minifat_start = blob.read_shift(4, 'i');

// Number of Mini FAT Sectors
    nmfs = blob.read_shift(4, 'i');

// First DIFAT sector location
    difat_start = blob.read_shift(4, 'i');

// Number of DIFAT Sectors
    difat_sec_cnt = blob.read_shift(4, 'i');

// Grab FAT Sector Locations
    for (var q = -1, j = 0; j < 109; ++j) {
      /* 109 = (512 - blob.l)>>>2; */
      q = blob.read_shift(4, 'i');
      if (q < 0) break;
      fat_addrs[j] = q;
    }

    /** Break the file up into sectors */
    var sectors /*:Array<RawBytes>*/ = sectorify(file, ssz);

    sleuth_fat(difat_start, difat_sec_cnt, sectors, ssz, fat_addrs);

    /** Chains */
    var sector_list /*:SectorList*/ =
        make_sector_list(sectors, dir_start, fat_addrs, ssz);

    if (dir_start < sector_list.length) {
      sector_list[dir_start].name = "!Directory";
    }
    if (nmfs > 0 && minifat_start != ENDOFCHAIN) {
      sector_list[minifat_start].name = "!MiniFAT";
    }
    sector_list[fat_addrs[0]].name = "!FAT";
    sector_list.fat_addrs = fat_addrs;
    sector_list.ssz = ssz;

/* [MS-CFB] 2.6.1 Compound File Directory Entry */
    var files /*:CFBFiles*/ = {},
        Paths /*:Array<string>*/ = [],
        FileIndex /*:CFBFileIndex*/ = [],
        FullPaths /*:Array<string>*/ = [];
    read_directory(dir_start, sector_list, sectors, Paths, nmfs, files,
        FileIndex, minifat_start);

    build_full_paths(FileIndex, FullPaths, Paths);
    Paths.shift();

    var o = CFBContainer(FileIndex: FileIndex, FullPaths: FullPaths);

// $FlowIgnore
    if (options && options.raw) o.raw = {header: header, sectors: sectors};
    return o;
  }

  write() {}

  write_file() {}
}
