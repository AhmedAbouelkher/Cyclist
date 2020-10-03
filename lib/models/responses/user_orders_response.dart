//! DISABLED
class UserOrdersResponse {
  int currentPage;
  List<Order> orders;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  UserOrdersResponse(
      {this.currentPage,
      this.orders,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  UserOrdersResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      orders = new List<Order>();
      json['data'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.orders != null) {
      data['data'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Order {
  int id;
  String userId;
  String status;
  String address;
  String note;
  String day;
  String time;
  String totalPrice;
  String createdAt;
  String updatedAt;
  String longitude;
  String latitude;
  int statusIndex;
  bool rate;
  List<Products> products;

  Order(
      {this.id,
      this.userId,
      this.status,
      this.address,
      this.note,
      this.day,
      this.time,
      this.totalPrice,
      this.createdAt,
      this.statusIndex,
      this.updatedAt,
      this.longitude,
      this.latitude,
      this.rate,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    address = json['address'];
    note = json['note'];
    day = json['day'];
    time = json['time'];
    statusIndex = json['status_index'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    rate = json['rate'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['address'] = this.address;
    data['note'] = this.note;
    data['day'] = this.day;
    data['time'] = this.time;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['rate'] = this.rate;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String nameAr;
  String nameEn;
  String descriptionEn;
  String descriptionAr;
  String categoryId;
  String salePrice;
  String image;
  List<Specifications> specifications;
  String createdAt;
  String updatedAt;
  String imagePath;
  String name;
  String description;
  bool favorite;
  Pivot pivot;

  Products(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionEn,
      this.descriptionAr,
      this.categoryId,
      this.salePrice,
      this.image,
      this.specifications,
      this.createdAt,
      this.updatedAt,
      this.imagePath,
      this.name,
      this.description,
      this.favorite,
      this.pivot});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    categoryId = json['category_id'];
    salePrice = json['sale_price'];
    image = json['image'];
    if (json['specifications'] != null) {
      specifications = new List<Specifications>();
      json['specifications'].forEach((v) {
        specifications.add(new Specifications.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['image_path'];
    name = json['name'];
    description = json['description'];
    favorite = json['favorite'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['category_id'] = this.categoryId;
    data['sale_price'] = this.salePrice;
    data['image'] = this.image;
    if (this.specifications != null) {
      data['specifications'] = this.specifications.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_path'] = this.imagePath;
    data['name'] = this.name;
    data['description'] = this.description;
    data['favorite'] = this.favorite;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String orderId;
  String productId;
  String quantity;
  List<Specifications> specifications;

  Pivot({this.orderId, this.productId, this.quantity, this.specifications});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    if (json['specifications'] != null) {
      specifications = new List<Specifications>();
      json['specifications'].forEach((v) {
        specifications.add(new Specifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    if (this.specifications != null) {
      data['specifications'] = this.specifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specifications {
  String nameAr;
  String nameEn;
  List<Order> data;
  String price;
  Specifications({this.nameAr, this.nameEn, this.data, this.price});

  Specifications.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    if (json['data'] != null) {
      data = new List<Order>();
      json['data'].forEach((v) {
        data.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
