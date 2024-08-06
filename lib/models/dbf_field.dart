class DBFField {
  /// Original Field Name
  final String? name;

  /// Field Type
  final String? type;

  /// Field Length
  final num? len;

  /// Field Decimal Count
  final num? dec;

  const DBFField({
    this.name,
    this.type,
    this.len,
    this.dec,
  });
}
