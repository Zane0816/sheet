import 'dart:collection';

import 'package:sheet/models/comment.dart';

class Comments extends ListBase<Comment> {
  /// Hide comment by default
  final bool? hidden;

  Comments({
    this.hidden,
  });

  @override
  int get length => 0;

  @override
  operator [](int index) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void operator []=(int index, value) {
    // TODO: implement []=
  }

  @override
  set length(int newLength) {
    // TODO: implement length
  }
}
