// import 'package:cyclist/models/responses/show_cat_products.dart';

// class FavoritesResponse {
//   List<Product> favorites;

//   FavoritesResponse({this.favorites});

//   FavoritesResponse.fromJson(Map<String, dynamic> json) {
//     if (json['favorites'] != null) {
//       favorites = new List<Product>();
//       json['favorites'].forEach((v) {
//         favorites.add(new Product.fromFavJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.favorites != null) {
//       data['favorites'] = this.favorites.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
