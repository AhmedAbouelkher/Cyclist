//! DISABLED
// class ConfirmCodeResponse {
//   String message;
//   String tokenType;
//   String accessToken;
//   String expiresAt;
//   User user;

//   ConfirmCodeResponse(
//       {this.message,
//       this.tokenType,
//       this.accessToken,
//       this.expiresAt,
//       this.user});

//   ConfirmCodeResponse.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     tokenType = json['token_type'];
//     accessToken = json['access_token'];
//     expiresAt = json['expires_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['token_type'] = this.tokenType;
//     data['access_token'] = this.accessToken;
//     data['expires_at'] = this.expiresAt;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     return data;
//   }
// }

// class User {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String emailVerifiedAt;
//   String image;
//   String mobileToken;
//   String code;
//   String createdAt;
//   String updatedAt;
//   String address;
//   String gender;
//   String imagePath;

//   User(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.emailVerifiedAt,
//       this.image,
//       this.mobileToken,
//       this.code,
//       this.createdAt,
//       this.updatedAt,
//       this.address,
//       this.gender,
//       this.imagePath});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     emailVerifiedAt = json['email_verified_at'];
//     image = json['image'];
//     mobileToken = json['mobile_token'];
//     code = json['code'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     address = json['address'];
//     gender = json['gender'];
//     imagePath = json['image_path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['image'] = this.image;
//     data['mobile_token'] = this.mobileToken;
//     data['code'] = this.code;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['address'] = this.address;
//     data['gender'] = this.gender;
//     data['image_path'] = this.imagePath;
//     return data;
//   }
// }
