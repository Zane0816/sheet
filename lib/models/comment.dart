class Comment {
  /// Author of the comment block
  final String? a;

  /// Plaintext of the comment
  final String t;

  /// If true, mark the comment as a part of a thread
  final bool? T;

  const Comment({
    this.a,
    required this.t,
    this.T,
  });
}
