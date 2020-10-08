// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
  CategoriesResponse({
    this.categories,
  });

  final Categories categories;

  CategoriesResponse copyWith({
    Categories categories,
  }) =>
      CategoriesResponse(
        categories: categories ?? this.categories,
      );

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null ? null : categories.toJson(),
      };
}

class Categories {
  Categories({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.basePageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  final List<Category> data;
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final String basePageUrl;
  final String nextPageUrl;
  final String prevPageUrl;

  Categories copyWith({
    List<Category> data,
    int total,
    int perPage,
    int currentPage,
    int lastPage,
    String basePageUrl,
    String nextPageUrl,
    String prevPageUrl,
  }) =>
      Categories(
        data: data ?? this.data,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        basePageUrl: basePageUrl ?? this.basePageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: json["data"] == null ? null : List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        basePageUrl: json["base_page_url"] == null ? null : json["base_page_url"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total == null ? null : total,
        "per_page": perPage == null ? null : perPage,
        "current_page": currentPage == null ? null : currentPage,
        "last_page": lastPage == null ? null : lastPage,
        "base_page_url": basePageUrl == null ? null : basePageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.imageHeader,
  });

  final int id;
  final String name;
  final String imageHeader;

  Category copyWith({
    int id,
    String name,
    String imageHeader,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        imageHeader: imageHeader ?? this.imageHeader,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        imageHeader: json["image_header"] == null ? null : "http://alaglate.ainzimati.tk" + json["image_header"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image_header": imageHeader == null ? null : imageHeader,
      };
}
