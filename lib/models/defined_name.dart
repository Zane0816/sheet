class DefinedName {
  /// Name
  final String Name;

  /// Reference
  final String Ref;

  /// Scope (undefined for workbook scope)
  final num? Sheet;

  /// Name comment
  final String? Comment;

  const DefinedName({
    required this.Name,
    required this.Ref,
    this.Sheet,
    this.Comment,
  });
}
