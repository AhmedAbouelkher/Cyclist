//! DISABLED
// import 'dart:convert';
// import 'package:cyclist/models/responses/confirm_code_response.dart';

// class UserModel {
//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.emailVerifiedAt,
//     this.image,
//     this.mobileToken,
//     this.code,
//     this.createdAt,
//     this.updatedAt,
//     this.address,
//     this.gender,
//     this.imagePath,
//   });

//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final dynamic emailVerifiedAt;
//   final String image;
//   final String mobileToken;
//   final String code;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic address;
//   final String gender;
//   final String imagePath;

//   factory UserModel.fromRawUserJson(String str) =>
//       UserModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     User user = User.fromJson(json);
//     return UserModel(
//       id: user.id,
//       name: user.id,
//       email: user.id,
//       phone: user.id,
//       emailVerifiedAt: user.id,
//       image: user.id,
//       mobileToken: user.id,
//       code: user.id,
//       createdAt: DateTime.parse(json["created_at"]),
//       updatedAt: DateTime.parse(json["updated_at"]),
//       address: json["address"],
//       gender: json["gender"],
//       imagePath: json["image_path"],
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "email_verified_at": emailVerifiedAt,
//         "image": image,
//         "mobile_token": mobileToken,
//         "code": code,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "address": address,
//         "gender": gender,
//         "image_path": imagePath,
//       };
// }
