// To parse this JSON data, do
//
//     final serachProductsResponse = serachProductsResponseFromJson(jsonString);

import 'dart:convert';

SerachProductsResponse serachProductsResponseFromJson(String str) => SerachProductsResponse.fromJson(json.decode(str));

String serachProductsResponseToJson(SerachProductsResponse data) => json.encode(data.toJson());

class SerachProductsResponse {
  SerachProductsResponse({
    this.products,
  });

  final Products products;

  SerachProductsResponse copyWith({
    Products products,
  }) =>
      SerachProductsResponse(
        products: products ?? this.products,
      );

  factory SerachProductsResponse.fromJson(Map<String, dynamic> json) => SerachProductsResponse(
        products: json["products"] == null ? null : Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? null : products.toJson(),
      };
}

class Products {
  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int currentPage;
  final List<Product> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  Products copyWith({
    int currentPage,
    List<Product> data,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    String nextPageUrl,
    String path,
    int perPage,
    dynamic prevPageUrl,
    int to,
    int total,
  }) =>
      Products(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionEn,
    this.descriptionAr,
    this.categoryId,
    this.salePrice,
    this.colors,
    this.stock,
    this.weight,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
    this.name,
    this.description,
    this.quantity,
  });

  int id;
  String nameAr;
  String nameEn;
  String descriptionEn;
  String descriptionAr;
  String categoryId;
  String salePrice;
  List<String> colors;
  String stock;
  String weight;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String imagePath;
  String name;
  String description;
  int quantity;

  Product copyWith({
    int id,
    String nameAr,
    String nameEn,
    String descriptionEn,
    String descriptionAr,
    String categoryId,
    String salePrice,
    List<String> colors,
    String stock,
    String weight,
    String image,
    DateTime createdAt,
    DateTime updatedAt,
    String imagePath,
    String name,
    String description,
    int quantity,
  }) =>
      Product(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        descriptionEn: descriptionEn ?? this.descriptionEn,
        descriptionAr: descriptionAr ?? this.descriptionAr,
        categoryId: categoryId ?? this.categoryId,
        salePrice: salePrice ?? this.salePrice,
        colors: colors ?? this.colors,
        stock: stock ?? this.stock,
        weight: weight ?? this.weight,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        nameAr: json["name_ar"] == null ? null : json["name_ar"],
        nameEn: json["name_en"] == null ? null : json["name_en"],
        descriptionEn: json["description_en"] == null ? null : json["description_en"],
        descriptionAr: json["description_ar"] == null ? null : json["description_ar"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        colors: json["colors"] == null ? null : List<String>.from(json["colors"].map((x) => x)),
        stock: json["stock"] == null ? null : json["stock"],
        weight: json["weight"] == null ? null : json["weight"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imagePath: json["image_path"] == null ? null : json["image_path"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name_ar": nameAr == null ? null : nameAr,
        "name_en": nameEn == null ? null : nameEn,
        "description_en": descriptionEn == null ? null : descriptionEn,
        "description_ar": descriptionAr == null ? null : descriptionAr,
        "category_id": categoryId == null ? null : categoryId,
        "sale_price": salePrice == null ? null : salePrice,
        "colors": colors == null ? null : List<dynamic>.from(colors.map((x) => x)),
        "stock": stock == null ? null : stock,
        "weight": weight == null ? null : weight,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "image_path": imagePath == null ? null : imagePath,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
      };

  @override
  String toString() {
    return '''
Product(
        id : $id
        categoryId : $categoryId
        salePrice : $salePrice
        colors : $colors
        stock : $stock
        weight : $weight
        imagePath : $imagePath
        name : $name
        quantity : $quantity
    )
    ''';
  }

  double get getTotalPrice {
    return this.quantity * double.parse(this.salePrice);
  }

  double get getTotalWieght {
    return this.quantity * double.parse(this.weight);
  }
}
