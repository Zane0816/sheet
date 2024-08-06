class Hyperlink {
  /// Target of the link (HREF)
  final String Target;

  /// Plaintext tooltip to display when mouse is over cell
  final String Tooltip;

  const Hyperlink({
    required this.Target,
    required this.Tooltip,
  });
}
