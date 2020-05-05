class Article {
  //
  int materialId;
  int diagnosisId;
  String title;
  String body;
  String link;
  String tags;
  String pictureUrl;

  //
  factory Article.fromJson(Map<String, dynamic> json) => Article()
    ..materialId = json['id_material'] as int
    ..diagnosisId = json['id_diagnosis'] as int
    ..title = json['title'] as String
    ..body = json['body'] as String
    ..link = json['link'] as String
    ..tags = json['tags'] as String
    ..pictureUrl = json['pictureUrl'] as String;

  Map<String, dynamic> toJson() => null;

  Article();
}
