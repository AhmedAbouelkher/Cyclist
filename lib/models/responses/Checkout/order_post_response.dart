// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    this.url,
    this.order,
  });

  String url;
  Order order;

  OrderResponse copyWith({
    String url,
    Order order,
  }) =>
      OrderResponse(
        url: url ?? this.url,
        order: order ?? this.order,
      );

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        url: json["url"] == null ? null : json["url"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "order": order == null ? null : order.toJson(),
      };
}

class Order {
  Order({
    this.name,
    this.phone,
    this.neighborhoodId,
    this.totalPrice,
    this.longitude,
    this.latitude,
    this.address,
    this.note,
    this.driverPrice,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.transactionNo,
  });

  String name;
  String phone;
  String neighborhoodId;
  double totalPrice;
  double longitude;
  double latitude;
  String address;
  String note;
  String driverPrice;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String transactionNo;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        // name: json["name"] == null ? null : json["name"],
        // phone: json["phone"] == null ? null : json["phone"],
        // neighborhoodId: json["neighborhood_id"] == null ? null : json["neighborhood_id"],
        // totalPrice: json["total_price"] == null ? null : json["total_price"].toDouble(),
        // longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        // latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        // address: json["address"] == null ? null : json["address"],
        // note: json["note"] == null ? null : json["note"],
        // driverPrice: json["driver_price"] == null ? null : json["driver_price"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        // id: json["id"] == null ? null : json["id"],
        transactionNo: json["transactionNo"] == null ? null : json["transactionNo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "neighborhood_id": neighborhoodId == null ? null : neighborhoodId,
        "total_price": totalPrice == null ? null : totalPrice,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "note": note == null ? null : note,
        "driver_price": driverPrice == null ? null : driverPrice,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
        "transactionNo": transactionNo == null ? null : transactionNo,
      };

  Order copyWith({
    String name,
    String phone,
    String neighborhoodId,
    double totalPrice,
    double longitude,
    double latitude,
    String address,
    String note,
    String driverPrice,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
    String transactionNo,
  }) =>
      Order(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        neighborhoodId: neighborhoodId ?? this.neighborhoodId,
        totalPrice: totalPrice ?? this.totalPrice,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        address: address ?? this.address,
        note: note ?? this.note,
        driverPrice: driverPrice ?? this.driverPrice,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        transactionNo: transactionNo ?? this.transactionNo,
      );
}
