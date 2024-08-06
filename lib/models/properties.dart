class Properties {
  /// Summary tab "Title"
  final String? Title;

  /// Summary tab "Subject"
  final String? Subject;

  /// Summary tab "Author"
  final String? Author;

  /// Summary tab "Manager"
  final String? Manager;

  /// Summary tab "Company"
  final String? Company;

  /// Summary tab "Category"
  final String? Category;

  /// Summary tab "Keywords"
  final String? Keywords;

  /// Summary tab "Comments"
  final String? Comments;

  /// Statistics tab "Last saved by"
  final String? LastAuthor;

  /// Statistics tab "Created"
  final DateTime? CreatedDate;

  const Properties({
    this.Title,
    this.Subject,
    this.Author,
    this.Manager,
    this.Company,
    this.Category,
    this.Keywords,
    this.Comments,
    this.LastAuthor,
    this.CreatedDate,
  });
}
