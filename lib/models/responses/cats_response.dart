// To parse this JSON data, do
//
//     final catsResponse = catsResponseFromJson(jsonString);

import 'dart:convert';

CatsResponse catsResponseFromJson(String str) => CatsResponse.fromJson(json.decode(str));

String catsResponseToJson(CatsResponse data) => json.encode(data.toJson());

class CatsResponse {
  CatsResponse({
    this.categories,
  });

  List<Category> categories;

  CatsResponse copyWith({
    List<Category> categories,
  }) =>
      CatsResponse(
        categories: categories ?? this.categories,
      );

  factory CatsResponse.fromJson(Map<String, dynamic> json) => CatsResponse(
        categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.position,
    this.updatedAt,
    this.name,
  });

  final int id;
  final String nameAr;
  final String nameEn;
  final DateTime createdAt;
  final String position;
  final DateTime updatedAt;
  final String name;

  Category copyWith({
    int id,
    String nameAr,
    String nameEn,
    DateTime createdAt,
    String position,
    DateTime updatedAt,
    String name,
  }) =>
      Category(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        createdAt: createdAt ?? this.createdAt,
        position: position ?? this.position,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        nameAr: json["name_ar"] == null ? null : json["name_ar"],
        nameEn: json["name_en"] == null ? null : json["name_en"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        position: json["position"] == null ? null : json["position"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name_ar": nameAr == null ? null : nameAr,
        "name_en": nameEn == null ? null : nameEn,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "position": position == null ? null : position,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "name": name == null ? null : name,
      };
}
