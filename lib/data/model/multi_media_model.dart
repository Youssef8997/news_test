class MultimediaModel {
  final String url;
  final String subtype;
  final String caption;

  MultimediaModel(
      {required this.url, required this.subtype, required this.caption});
  factory MultimediaModel.fromJson(Map<String, dynamic> json) =>
      MultimediaModel(
        url: json["url"],
        caption: json["caption"],
        subtype: json["subtype"],
      );
  Map<String, dynamic> toMap() => {
        "url": url,
        "caption": caption,
        "subtype": subtype,
      };
}
