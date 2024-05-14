// To parse this JSON data, do
//
//     final articleModels = articleModelsFromJson(jsonString);

import 'dart:convert';

ArticleModels articleModelsFromJson(String str) =>
    ArticleModels.fromJson(json.decode(str));

String articleModelsToJson(ArticleModels data) => json.encode(data.toJson());

class ArticleModels {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  ArticleModels({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticleModels.fromJson(Map<String, dynamic> json) => ArticleModels(
        status: json["status"] ?? '',
        totalResults: json["totalResults"] ?? 0,
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source:
            json["source"] == null ? Source() : Source.fromJson(json["source"]),
        author: json["author"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? '',
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: json["publishedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

class Source {
  final Id? id;
  final Name? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id { techcrunch, theNextWeb }

final idValues =
    EnumValues({"techcrunch": Id.techcrunch, "the-next-web": Id.theNextWeb});

enum Name { techCrunch, theNextWeb }

final nameValues = EnumValues(
    {"TechCrunch": Name.techCrunch, "The Next Web": Name.theNextWeb});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
