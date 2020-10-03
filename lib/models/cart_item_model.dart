import 'dart:convert' as convert;

//! DISABLED
class Spc {
  final String nameAr;
  final String nameEm;
  final double price;

  Spc({
    this.nameAr,
    this.nameEm,
    this.price,
  });

  factory Spc.fromJson(Map<String, String> map) {
    return Spc(
      nameAr: map['nameAr'],
      nameEm: map['nameEm'],
      price: double.parse(map['price']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameAr'] = this.nameAr;
    data['nameEm'] = this.nameEm;
    data['price'] = this.price;
    return data;
  }

  Map<String, dynamic> toOrderMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameAr'] = this.nameAr;
    data['nameEm'] = this.nameEm;
    data['price'] = this.price;
    return data;
  }
}

class CartItem {
  String id;
  int quantity;
  double price;
  String imgPath;
  String nameAr;
  String nameEn;
  List<Spc> spcsList;

  CartItem({this.id, this.quantity, this.price, this.imgPath, this.nameAr, this.nameEn, this.spcsList});

  CartItem.fromPrefs(String itemString) {
    var itemMap = convert.jsonDecode(itemString);
    this.id = itemMap['id'];
    this.quantity = itemMap['quantity'];
    this.price = itemMap['price'];
    this.imgPath = itemMap['imgPath'];
    this.nameAr = itemMap['nameAr'];
    this.nameEn = itemMap['nameEn'];
    if (itemMap['spcsList'] != null) {
      spcsList = new List<Spc>();
      itemMap['spcsList'].forEach((v) {
        // spcsList.add(Spc.fromJson(v));
      });
    } else {
      spcsList = [];
    }
  }
  String toJsonString() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['imgPath'] = this.imgPath;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;

    if (this.spcsList.length > 0) {
      data['spcsList'] = this.spcsList.map((v) => v.toJson()).toList();
    }

    return convert.jsonEncode(data);
  }

  double getPrice() {
    double totalPrice = 0;
    totalPrice = this.price;
    this.spcsList.forEach((element) {
      totalPrice += element.price;
    });
    return totalPrice * quantity;
  }

  Map<String, dynamic> toOrderMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['product_id'] = this.id;
    data['price'] = this.price;
    this.spcsList.forEach((element) {
      element.toOrderMap();
    });

    if (this.spcsList.length > 0) {
      data['spcsList'] = this.spcsList.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
