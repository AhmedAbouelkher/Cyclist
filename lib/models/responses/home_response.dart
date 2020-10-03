// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    this.sliders,
    this.cities,
  });

  final List<Slider> sliders;
  final List<City> cities;

  HomeResponse copyWith({
    List<Slider> sliders,
    List<City> cities,
  }) =>
      HomeResponse(
        sliders: sliders ?? this.sliders,
        cities: cities ?? this.cities,
      );

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        sliders: json["sliders"] == null ? null : List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
        cities: json["cities"] == null ? null : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sliders": sliders == null ? null : List<dynamic>.from(sliders.map((x) => x.toJson())),
        "cities": cities == null ? null : List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.neighborhoods,
    this.price,
    this.cityId,
  });

  final int id;
  final String nameAr;
  final String nameEn;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final List<City> neighborhoods;
  final String price;
  final String cityId;

  City copyWith({
    int id,
    String nameAr,
    String nameEn,
    DateTime createdAt,
    DateTime updatedAt,
    String name,
    List<City> neighborhoods,
    String price,
    String cityId,
  }) =>
      City(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        neighborhoods: neighborhoods ?? this.neighborhoods,
        price: price ?? this.price,
        cityId: cityId ?? this.cityId,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        nameAr: json["name_ar"] == null ? null : json["name_ar"],
        nameEn: json["name_en"] == null ? null : json["name_en"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        name: json["name"] == null ? null : json["name"],
        neighborhoods: json["neighborhoods"] == null ? null : List<City>.from(json["neighborhoods"].map((x) => City.fromJson(x))),
        price: json["price"] == null ? null : json["price"],
        cityId: json["city_id"] == null ? null : json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name_ar": nameAr == null ? null : nameAr,
        "name_en": nameEn == null ? null : nameEn,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "name": name == null ? null : name,
        "neighborhoods": neighborhoods == null ? null : List<dynamic>.from(neighborhoods.map((x) => x.toJson())),
        "price": price == null ? null : price,
        "city_id": cityId == null ? null : cityId,
      };
}

class Slider {
  Slider({
    this.id,
    this.image,
    this.title,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  final int id;
  final String image;
  final String title;
  final String link;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imagePath;

  Slider copyWith({
    int id,
    String image,
    String title,
    String link,
    DateTime createdAt,
    DateTime updatedAt,
    String imagePath,
  }) =>
      Slider(
        id: id ?? this.id,
        image: image ?? this.image,
        title: title ?? this.title,
        link: link ?? this.link,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        imagePath: imagePath ?? this.imagePath,
      );

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
        link: json["link"] == null ? null : json["link"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imagePath: json["image_path"] == null ? null : json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "title": title == null ? null : title,
        "link": link == null ? null : link,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "image_path": imagePath == null ? null : imagePath,
      };
}
