class PostOrder {
  PostOrder({
    this.name,
    this.phone,
    this.neighborhoodId,
    this.sale,
    this.totalPrice,
    this.longitude,
    this.latitude,
    this.address,
    this.note,
    this.typePayment,
    this.totalWeight,
    this.products,
    this.cityId,
  });

  final String name;
  final String phone;
  final int neighborhoodId;
  final int cityId;
  final double sale;
  final double totalPrice;
  final double longitude;
  final double latitude;
  final String address;
  final String note;
  final String typePayment;
  final double totalWeight;
  final List<Product> products;

  PostOrder copyWith({
    String name,
    String phone,
    int neighborhoodId,
    int ciyyId,
    double sale,
    double totalPrice,
    double longitude,
    double latitude,
    String address,
    String note,
    String typePayment,
    double totalWeight,
    List<Product> products,
  }) =>
      PostOrder(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        neighborhoodId: neighborhoodId ?? this.neighborhoodId,
        sale: sale ?? this.sale,
        totalPrice: totalPrice ?? this.totalPrice,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        address: address ?? this.address,
        note: note ?? this.note,
        typePayment: typePayment ?? this.typePayment,
        totalWeight: totalWeight ?? this.totalWeight,
        products: products ?? this.products,
        cityId: ciyyId ?? this.cityId,
      );

  factory PostOrder.fromJson(Map<String, dynamic> json) => PostOrder(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        neighborhoodId: json["neighborhood_id"] == null ? null : json["neighborhood_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        sale: json["sale"] == null ? null : json["sale"].toDouble(),
        totalPrice: json["total_price"] == null ? null : json["total_price"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        note: json["note"] == null ? null : json["note"],
        typePayment: json["type_payment"] == null ? null : json["type_payment"],
        totalWeight: json["totalWeight"] == null ? null : json["totalWeight"].toDouble(),
        products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "neighborhood_id": neighborhoodId == null ? null : neighborhoodId,
        "city_id": cityId == null ? null : cityId,
        "sale": sale == null ? null : sale,
        "total_price": totalPrice == null ? null : totalPrice,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "note": note == null ? null : note,
        "type_payment": typePayment == null ? null : typePayment,
        "totalWeight": totalWeight == null ? null : totalWeight,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.quantity,
    this.color,
    this.productId,
  });

  final int quantity;
  final String color;
  final int productId;

  Product copyWith({
    int quantity,
    String color,
    int productId,
  }) =>
      Product(
        quantity: quantity ?? this.quantity,
        color: color ?? this.color,
        productId: productId ?? this.productId,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        quantity: json["quantity"] == null ? null : json["quantity"],
        color: json["color"] == null ? null : json["color"],
        productId: json["product_id"] == null ? null : json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity == null ? null : quantity,
        "color": color == null ? null : color,
        "product_id": productId == null ? null : productId,
      };
}
