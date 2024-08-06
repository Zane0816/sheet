class WorkbookProperties {
  /// Worksheet Epoch (1904 if true, 1900 if false)
  final bool? date1904;

  /// Warn or strip personally identifying info on save
  final bool? filterPrivacy;

  /// Name of Document Module in associated VBA Project
  final String? CodeName;

  const WorkbookProperties({
    this.date1904,
    this.filterPrivacy,
    this.CodeName,
  });
}
