import 'package:sheet/cfb/models/cfb_entry.dart';

class CFBContainer {
  List<String> FullPaths;
  List<CFBEntry> FileIndex;

  CFBContainer({
    required this.FullPaths,
    required this.FileIndex,
  });
}
