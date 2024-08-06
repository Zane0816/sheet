class UTCOption {
  /// For plaintext formats, interpret ambiguous datetimes in UTC
  /// If explicitly set to `false`, dates will be parsed in local time.
  ///
  /// The `true` option is consistent with spreadsheet application export.
  ///
  /// @default true
  final bool? UTC;

  const UTCOption({
    this.UTC,
  });
}
