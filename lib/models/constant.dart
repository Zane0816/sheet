class Constant {
  static const VALID_ANSI = [
    874,
    932,
    936,
    949,
    950,
    1250,
    1251,
    1252,
    1253,
    1254,
    1255,
    1256,
    1257,
    1258,
    10000
  ];
  static const CS2CP = ({
    0: 1252,
    /* ANSI */
    1: 65001,
    /* DEFAULT */
    2: 65001,
    /* SYMBOL */
    77: 10000,
    /* MAC */
    128: 932,
    /* SHIFTJIS */
    129: 949,
    /* HANGUL */
    130: 1361,
    /* JOHAB */
    134: 936,
    /* GB2312 */
    136: 950,
    /* CHINESEBIG5 */
    161: 1253,
    /* GREEK */
    162: 1254,
    /* TURKISH */
    163: 1258,
    /* VIETNAMESE */
    177: 1255,
    /* HEBREW */
    178: 1256,
    /* ARABIC */
    186: 1257,
    /* BALTIC */
    204: 1251,
    /* RUSSIAN */
    222: 874,
    /* THAI */
    238: 1250,
    /* EASTEUROPE */
    255: 1252,
    /* OEM */
    69: 6969 /* MISC */
  } /*:any*/);

  static const DBF_SUPPORTED_VERSIONS = [
    0x02,
    0x03,
    0x30,
    0x31,
    0x83,
    0x8B,
    0x8C,
    0xF5
  ];

  static final chr0 = RegExp(r'\u0000', multiLine: true);
  static final chr1 = RegExp(r'[\u0001-\u0006]', multiLine: true);
}
