import 'multi_media_model.dart';

class ArticlesModel {
  final String section;
  final String title;
  final String url;
  final String abstract;
  final String byline;
  final String publishedDate;
  final List<MultimediaModel> multimedia;

  ArticlesModel(
      {required this.section,
      required this.title,
      required this.url,
      required this.abstract,
      required this.byline,
      required this.publishedDate,
      required this.multimedia});

  factory ArticlesModel.fromJson(Map<String, dynamic> json) => ArticlesModel(
      title: json["title"],
      abstract: json["abstract"],
      url: json["url"],
      byline: json["byline"],
      publishedDate: json["published_date"] ?? "",
      section: json["section"],
      multimedia: List.generate(
          json["multimedia"] != null ? json["multimedia"].length : 0,
          (index) => MultimediaModel.fromJson(json["multimedia"][index])));
  Map<String, dynamic> toMap() => {
        "title": title,
        "abstract": abstract,
        "url": url,
        "byline": byline,
        "published_date": publishedDate,
        "section": section,
        "multimedia": List.generate(
            multimedia.length, (index) => multimedia[index].toMap()),
      };
}
