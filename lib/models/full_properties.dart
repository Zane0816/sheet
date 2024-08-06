import 'package:sheet/models/properties.dart';

class FullProperties extends Properties {
  final DateTime? ModifiedDate;
  final String? Application;
  final String? AppVersion;
  final String? DocSecurity;
  final bool? HyperlinksChanged;
  final bool? SharedDoc;
  final bool? LinksUpToDate;
  final bool? ScaleCrop;
  final num? Worksheets;
  final List<String>? SheetNames;
  final String? ContentStatus;
  final String? LastPrinted;
  final dynamic Revision; //string | number
  final String? Version;
  final String? Identifier;
  final String? Language;

  const FullProperties({
    super.Title,
    super.Subject,
    super.Author,
    super.Manager,
    super.Company,
    super.Category,
    super.Keywords,
    super.Comments,
    super.LastAuthor,
    super.CreatedDate,
    this.ModifiedDate,
    this.Application,
    this.AppVersion,
    this.DocSecurity,
    this.HyperlinksChanged,
    this.SharedDoc,
    this.LinksUpToDate,
    this.ScaleCrop,
    this.Worksheets,
    this.SheetNames,
    this.ContentStatus,
    this.LastPrinted,
    this.Revision,
    this.Version,
    this.Identifier,
    this.Language,
  });
}
